import { spawn } from 'node:child_process';
import { mkdir, readFile, writeFile } from 'node:fs/promises';
import { createHash } from 'node:crypto';
import path from 'node:path';
import { parseArgs } from 'node:util';
import { entries, root } from './catalog.mjs';

const { values } = parseArgs({ options: {
  devices: { type: 'string' }, entries: { type: 'string' }, output: { type: 'string' }, help: { type: 'boolean' },
} });
if (values.help) {
  console.log(`Record native XCTest captures for review (macOS with Xcode required).

node scripts/capture-catalog.mjs --devices <simulator-UUIDs> \\
  --entries alert-actions,alert-text-fields --output work/alert-comparison

Comma-separate simulator UUIDs. Omit --entries to capture the entire catalog.
Use a new output folder for each run. This builds the app, runs native capture
tests, exports original attachments, and saves one import-metadata JSON per
device. Review the images before using import-captures.mjs; nothing is imported
automatically. A failed test run still exports available evidence and exits 1.
Do not edit the catalog or run another build while this command is running.`);
  process.exit(0);
}
if (!values.devices || !values.output) throw new Error('Provide --devices and --output. See --help.');
const output = path.resolve(root, values.output);
if (!output.startsWith(`${path.join(root, 'work')}${path.sep}`)) throw new Error('Keep capture-run artifacts in a new folder under work/.');

async function command(program, args, { allowFailure = false, quiet = false } = {}) {
  let stdout = '', stderr = '';
  const exitCode = await new Promise((resolve, reject) => {
    const child = spawn(program, args, { cwd: root, stdio: ['ignore', 'pipe', 'pipe'] });
    child.stdout.on('data', chunk => { stdout += chunk; if (!quiet) process.stdout.write(chunk); });
    child.stderr.on('data', chunk => { stderr += chunk; if (!quiet) process.stderr.write(chunk); });
    child.on('error', reject);
    child.on('close', resolve);
  });
  if (exitCode !== 0 && !allowFailure) throw new Error(`${program} exited ${exitCode}: ${stderr.trim()}`);
  return { stdout, stderr, exitCode };
}

const catalog = await entries();
const selectedIDs = new Set(values.entries?.split(',') ?? catalog.map(entry => entry.id));
for (const id of selectedIDs) if (!catalog.some(entry => entry.id === id)) throw new Error(`Unknown entry: ${id}`);
const inventory = JSON.parse((await command('xcrun', ['simctl', 'list', '--json'], { quiet: true })).stdout);
const devices = [...new Set(values.devices.split(','))].map(id => {
  for (const [runtimeID, candidates] of Object.entries(inventory.devices)) {
    const device = candidates.find(item => item.udid === id && item.isAvailable);
    const runtime = inventory.runtimes.find(item => item.identifier === runtimeID && item.isAvailable);
    if (device && runtime) return { device, runtime };
  }
  throw new Error(`Unavailable simulator UUID: ${id}`);
});
const xcode = (await command('xcodebuild', ['-version'], { quiet: true })).stdout.trim().replace(/\n/g, '; ');
const sdk = (await command('xcrun', ['--sdk', 'iphonesimulator', '--show-sdk-version'], { quiet: true })).stdout.trim();
await mkdir(path.dirname(output), { recursive: true });
await mkdir(output); // Refuse to overwrite a previous result bundle or review evidence.
await command(process.execPath, ['scripts/sync-catalog.mjs']);
await command(process.execPath, ['scripts/sync-capture-tests.mjs']);

const sourceHashes = {};
for (const entry of catalog.filter(item => selectedIDs.has(item.id))) {
  sourceHashes[entry.id] = createHash('sha256').update(await readFile(path.join(entry.directory, entry.swiftFile))).digest('hex');
}
for (const { device, runtime } of devices) {
  await writeFile(path.join(output, `environment-${device.udid}.json`), `${JSON.stringify({
    device: device.name, os: runtime.version, osBuild: runtime.buildversion,
    sdk: `iOS ${sdk}`, xcode, appearance: 'light', textSize: 'Large', locale: 'en_US',
    sourceHashes, states: {},
  }, null, 2)}\n`);
}
await writeFile(path.join(output, 'run.json'), `${JSON.stringify({ selectedIDs: [...selectedIDs], devices: devices.map(item => item.device.udid), sourceHashes }, null, 2)}\n`);
const resultBundle = path.join(output, 'Results.xcresult');
const args = ['-project', 'app/Atlas/Atlas.xcodeproj', '-scheme', 'Atlas',
  '-derivedDataPath', path.join(output, 'DerivedData'), '-resultBundlePath', resultBundle,
  '-parallel-testing-enabled', 'YES', '-parallel-testing-worker-count', '1',
  '-maximum-concurrent-test-simulator-destinations', '3', '-collect-test-diagnostics', 'never'];
for (const { device } of devices) args.push('-destination', `platform=iOS Simulator,id=${device.udid}`);
for (const id of selectedIDs) args.push(`-only-testing:AtlasUITests/CatalogCaptureTests/testCapture_${id.replaceAll('-', '_')}`);
args.push('test', 'CODE_SIGNING_ALLOWED=NO');
const result = await command('xcodebuild', args, { allowFailure: true });
await writeFile(path.join(output, 'xcodebuild.log'), result.stdout + result.stderr);
const exported = await command('xcrun', ['xcresulttool', 'export', 'attachments', '--path', resultBundle, '--output-path', path.join(output, 'attachments')], { allowFailure: true });
console.log(`Review evidence in ${path.relative(root, output)}. Import only verified images using the matching environment JSON.`);
if (result.exitCode !== 0 || exported.exitCode !== 0) process.exitCode = 1;

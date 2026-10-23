import { readFile, writeFile, copyFile, access } from 'node:fs/promises';
import { constants } from 'node:fs';
import { createHash } from 'node:crypto';
import path from 'node:path';
import { parseArgs } from 'node:util';
import { entries } from './catalog.mjs';

const { values } = parseArgs({ options: {
  export: { type: 'string' }, metadata: { type: 'string' }, entries: { type: 'string' }, help: { type: 'boolean' },
} });
if (values.help) {
  console.log(`Import named XCTest screenshot attachments into selected catalog entries.

node scripts/import-captures.mjs --export work/exported-captures \\
  --metadata work/capture-environment.json --entries alert-actions,alert-text-fields

The export directory must contain xcresulttool's manifest.json. Metadata is JSON:
{
  "device": "exact device name from the test result",
  "os": "runtime version", "osBuild": "runtime build",
  "sdk": "build SDK version", "xcode": "version and build",
  "appearance": "light", "textSize": "large", "locale": "en_US",
  "framing": "isolated",
  "states": { "alert-actions": "Two actions; destructive primary" }
}

Only atlas--<selected-entry>--<scenario> PNG attachments are imported.
Timestamps and device names come from the test attachment. Source hashes refer
to the current Swift files: import before editing the code used for the capture.
Original PNGs are copied without modification. Existing captures are preserved.`);
  process.exit(0);
}
if (!values.export || !values.metadata || !values.entries) throw new Error('Provide --export, --metadata, and --entries. See --help.');
const selected = new Set(values.entries.split(','));
const catalog = await entries();
for (const id of selected) if (!catalog.some(entry => entry.id === id)) throw new Error(`Unknown entry: ${id}`);
const environment = JSON.parse(await readFile(values.metadata, 'utf8'));
for (const field of ['device', 'os', 'osBuild', 'sdk', 'xcode', 'appearance', 'textSize', 'locale']) {
  if (typeof environment[field] !== 'string' || !environment[field].trim()) throw new Error(`Missing metadata: ${field}`);
}
const manifest = JSON.parse(await readFile(path.join(values.export, 'manifest.json'), 'utf8'));
const attachments = manifest.flatMap(test => test.attachments);
const digest = bytes => createHash('sha256').update(bytes).digest('hex');
const slug = text => text.toLowerCase().replace(/[^a-z0-9]+/g, '-').replace(/^-|-$/g, '');
const plan = [];
for (const entry of catalog.filter(entry => selected.has(entry.id))) {
  const sourceSHA256 = digest(await readFile(path.join(entry.directory, entry.swiftFile)));
  if (environment.sourceHashes && environment.sourceHashes[entry.id] !== sourceSHA256) {
    throw new Error(`Source changed since this capture run: ${entry.id}. Restore the matching source or record it again.`);
  }
  const matches = attachments.filter(attachment => attachment.deviceName === environment.device && attachment.suggestedHumanReadableName?.startsWith(`atlas--${entry.id}--`));
  if (!matches.length) throw new Error(`No named captures for ${entry.id}`);
  const captures = [...entry.captures];
  for (const attachment of matches) {
    if (attachment.deviceName !== environment.device) throw new Error(`Device mismatch for ${entry.id}: ${attachment.deviceName}`);
    const scenario = attachment.suggestedHumanReadableName.slice(`atlas--${entry.id}--`.length).match(/^([a-z0-9-]+)_/i)?.[1];
    if (!scenario || !attachment.exportedFileName.endsWith('.png')) throw new Error(`Invalid PNG attachment for ${entry.id}`);
    if (path.basename(attachment.exportedFileName) !== attachment.exportedFileName) throw new Error('Invalid exported file path');
    const sourcePath = path.join(values.export, attachment.exportedFileName);
    const png = await readFile(sourcePath);
    if (png.subarray(0, 8).toString('hex') !== '89504e470d0a1a0a') throw new Error(`Invalid PNG: ${sourcePath}`);
    const capturedAt = new Date(attachment.timestamp * 1000).toISOString();
    const file = `ios-${slug(environment.os)}-${slug(environment.device)}-${scenario}-${attachment.timestamp}.png`;
    const destination = path.join(entry.directory, 'captures', file);
    const capture = {
      file, device: environment.deviceModel ?? attachment.deviceName, os: environment.os, osBuild: environment.osBuild,
      ...(environment.deviceModel && environment.deviceModel !== attachment.deviceName ? { simulatorName: attachment.deviceName } : {}),
      sdk: environment.sdk, xcode: environment.xcode, appearance: environment.appearance,
      textSize: environment.textSize, locale: environment.locale,
      state: environment.states?.[entry.id] ?? entry.captureState ?? scenario, capturedAt,
      ...([environment.environmentNotes, entry.captureEnvironmentNotes].some(Boolean) ? { environmentNotes: [environment.environmentNotes, entry.captureEnvironmentNotes].filter(Boolean).join(' ') } : {}),
      framing: environment.framing ?? entry.captureStyle ?? 'screen',
      sourceSHA256,
    };
    const existing = captures.find(item => item.file === file);
    if (existing) {
      if (JSON.stringify(existing) !== JSON.stringify(capture) || digest(await readFile(destination)) !== digest(png)) {
        throw new Error(`Refusing to overwrite a different capture: ${destination}`);
      }
      continue;
    }
    try {
      await access(destination);
      throw new Error(`Unregistered capture already exists: ${destination}`);
    } catch (error) { if (error.code !== 'ENOENT') throw error; }
    captures.push(capture);
    plan.push({ sourcePath, destination });
  }
  const images = captures.map(capture => `### ${capture.device} · iOS ${capture.os}\n\n${capture.state}. ${capture.appearance} appearance; ${capture.textSize} text; ${capture.locale}.\n\n![${entry.title} on ${capture.device}, iOS ${capture.os}](captures/${capture.file})`).join('\n\n');
  if (!/<!-- captures:start -->[\s\S]*?<!-- captures:end -->/.test(entry.markdown)) throw new Error(`Missing capture markers: ${entry.id}`);
  plan.push({ entry, captures, markdown: entry.markdown.replace(/<!-- captures:start -->[\s\S]*?<!-- captures:end -->/, `<!-- captures:start -->\n${images}\n<!-- captures:end -->`) });
}
// Validate the complete batch before writing anything.
for (const item of plan) {
  if (item.sourcePath) await copyFile(item.sourcePath, item.destination, constants.COPYFILE_EXCL);
  else {
    await writeFile(path.join(item.entry.directory, 'captures/manifest.json'), `${JSON.stringify({ captures: item.captures }, null, 2)}\n`);
    await writeFile(path.join(item.entry.directory, 'README.md'), item.markdown);
  }
}
console.log(`Imported ${plan.filter(item => item.sourcePath).length} original captures for ${selected.size} selected entries.`);

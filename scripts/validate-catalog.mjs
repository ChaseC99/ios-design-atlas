import { access, readFile, readlink } from 'node:fs/promises';
import path from 'node:path';
import { entries, root } from './catalog.mjs';

const catalog = await entries();
const ids = new Set();
const names = new Set();
const errors = [];
for (const entry of catalog) {
  const fail = message => errors.push(`${entry.id ?? entry.directory}: ${message}`);
  for (const field of ['id', 'title', 'summary', 'category', 'family', 'kind', 'demoMinIOS', 'swiftFile', 'view']) {
    if (typeof entry[field] !== 'string' || !entry[field]) fail(`missing ${field}`);
  }
  if (!/^[a-z0-9]+(?:-[a-z0-9]+)*$/.test(entry.id)) fail('ID must be a stable kebab-case slug');
  if (ids.has(entry.id)) fail('duplicate ID');
  if (names.has(entry.swiftFile)) fail('duplicate Swift filename');
  ids.add(entry.id); names.add(entry.swiftFile);
  if (!/^\d+\.\d+$/.test(entry.demoMinIOS ?? '')) fail('demoMinIOS must be major.minor');
  if (!Number.isFinite(entry.order)) fail('order must be a number');
  for (const field of ['ownsNavigation', 'captureKeyboard', 'captureScroll']) {
    if (entry[field] !== undefined && typeof entry[field] !== 'boolean') fail(`${field} must be boolean`);
  }
  if (entry.captureAction && !['tap', 'longPress'].includes(entry.captureAction)) fail('unsupported captureAction');
  if (entry.captureNavigation !== undefined && typeof entry.captureNavigation !== 'boolean') fail('captureNavigation must be boolean');
  if (!Array.isArray(entry.apis) || !entry.apis.length) fail('APIs are required');
  if (!Array.isArray(entry.tags)) fail('tags must be an array');
  try {
    const code = await readFile(path.join(entry.directory, entry.swiftFile), 'utf8');
    if (!code.includes(`struct ${entry.view}: View`)) fail('Swift view does not match metadata');
    const link = path.join(root, 'app/Atlas/Atlas/Examples', entry.swiftFile);
    if (path.resolve(path.dirname(link), await readlink(link)) !== path.join(entry.directory, entry.swiftFile)) fail('wrong Swift symlink');
  } catch (error) { fail(error.message); }
  const prose = entry.markdown.replace(/^```[^\n]*\n[\s\S]*?^```\s*$/gm, '').replace(/`[^`\n]*`/g, '');
  for (const match of prose.matchAll(/!?\[[^\]]*\]\(([^)]+)\)/g)) {
    const url = match[1];
    if (/^(https?:|#)/.test(url)) continue;
    try { await access(path.resolve(entry.directory, url)); } catch { fail(`broken local link: ${url}`); }
  }
  for (const capture of entry.captures ?? []) {
    for (const field of ['file', 'device', 'os', 'osBuild', 'sdk', 'xcode', 'appearance', 'textSize', 'locale', 'state', 'capturedAt', 'sourceSHA256']) {
      if (!capture[field]) fail(`capture missing ${field}`);
    }
    try { await access(path.join(entry.directory, 'captures', capture.file)); } catch { fail(`missing capture ${capture.file}`); }
  }
}
if (!catalog.length) errors.push('Catalog is empty');
if (errors.length) { console.error(errors.join('\n')); process.exit(1); }
console.log(`Validated ${catalog.length} entries, local links, Swift references, and capture provenance.`);

import { readdir, readFile } from 'node:fs/promises';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import { parse } from 'yaml';

export const root = fileURLToPath(new URL('..', import.meta.url));
export async function entries() {
  const base = path.join(root, 'catalog');
  const files = await readdir(base, { recursive: true });
  const result = await Promise.all(files.filter(file => file.endsWith('/README.md')).map(async file => {
    const directory = path.dirname(path.join(base, file));
    const markdown = await readFile(path.join(directory, 'README.md'), 'utf8');
    const match = markdown.match(/^---\n([\s\S]*?)\n---\n/);
    if (!match) throw new Error(`${file}: missing frontmatter`);
    const data = parse(match[1], { maxAliasCount: 0 });
    const manifest = JSON.parse(await readFile(path.join(directory, 'captures/manifest.json'), 'utf8'));
    return { ...data, directory, markdown, captures: manifest.captures };
  }));
  return result.sort((a, b) => a.order - b.order);
}

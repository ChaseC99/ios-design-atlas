import type { CollectionEntry } from 'astro:content';
import type { ImageMetadata } from 'astro';

const images = import.meta.glob<ImageMetadata>('../../../catalog/**/captures/**/*.png', { eager: true, import: 'default' });
const manifests = import.meta.glob<{ captures: Capture[] }>('../../../catalog/**/captures/manifest.json', { eager: true, import: 'default' });
const sources = import.meta.glob<string>('../../../catalog/**/*.swift', { eager: true, query: '?raw', import: 'default' });
export interface Capture {
  file: string; device: string; os: string; osBuild: string; state: string;
  appearance: string; textSize: string; locale: string; xcode: string; sdk: string;
  capturedAt: string; sourceSHA256: string; image?: ImageMetadata;
  framing?: 'screen' | 'isolated';
}
export async function details(entry: CollectionEntry<'catalog'>) {
  const manifestPath = Object.keys(manifests).find(key => key.endsWith(`/${entry.id}/captures/manifest.json`));
  if (!manifestPath) throw new Error(`Missing capture manifest for ${entry.id}`);
  const directory = manifestPath.replace('/captures/manifest.json', '');
  const manifest = manifests[`${directory}/captures/manifest.json`];
  if (!manifest) throw new Error(`Missing capture manifest for ${entry.id}`);
  const captures: Capture[] = manifest.captures.map((capture: Capture) => ({
    ...capture,
    image: images[`${directory}/captures/${capture.file}`],
  })).sort((a, b) => a.os.localeCompare(b.os, undefined, { numeric: true }));
  const source = sources[`${directory}/${entry.data.swiftFile}`];
  if (!source) throw new Error(`Missing Swift source for ${entry.id}`);
  const body = entry.body ?? '';
  const description = body.split(/\n\s*\n/).map(part => part.trim())
    .find(part => part && !/^(#|```|<!--)/.test(part)) ?? entry.data.summary;
  const snippet = body.match(/^```swift\s*\n([\s\S]*?)^```/m)?.[1].trim();
  return { captures, source, description, snippet, catalogPath: directory.replace('../../../', '') };
}
export function collections(entries: CollectionEntry<'catalog'>[]) {
  return [...new Set(entries.map(entry => entry.data.category))].map(name => ({
    name,
    entries: entries.filter(entry => entry.data.category === name),
  }));
}
export const github = 'https://github.com/ChaseC99/ios-design-atlas';

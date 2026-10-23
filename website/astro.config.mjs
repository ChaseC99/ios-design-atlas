import { defineConfig } from 'astro/config';
import { fileURLToPath } from 'node:url';
import catalogMarkdown from './src/lib/catalog-markdown.mjs';
import { unified } from '@astrojs/markdown-remark';

export default defineConfig({
  output: 'static',
  markdown: { processor: unified({ remarkPlugins: [catalogMarkdown] }) },
  vite: {
    server: { fs: { allow: [fileURLToPath(new URL('..', import.meta.url))] } },
  },
});

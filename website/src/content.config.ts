import { defineCollection } from 'astro:content';
import { glob } from 'astro/loaders';
import { z } from 'astro/zod';

const catalog = defineCollection({
  loader: glob({
    base: new URL('../../catalog/', import.meta.url),
    pattern: '**/README.md',
    generateId: ({ data }) => String(data.id),
  }),
  schema: z.object({
    id: z.string(), title: z.string(), summary: z.string(), category: z.string(),
    family: z.string(), order: z.number(), kind: z.enum(['native', 'custom', 'observation']),
    demoMinIOS: z.string(), swiftFile: z.string(), view: z.string(),
    ownsNavigation: z.boolean().optional(), captureNavigation: z.boolean().optional(), captureStyle: z.enum(['screen', 'isolated']).optional(),
    apis: z.array(z.string()), tags: z.array(z.string()),
  }),
});
export const collections = { catalog };

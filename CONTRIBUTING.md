# Contributing an example

## Add an entry

1. Create `catalog/<category>/<stable-id>/`.
2. Add a self-contained SwiftUI view with a `NavigationStack` preview.
3. Add `README.md` with the metadata below, a one-sentence description, a small Swift example, and original references. The website uses the opening paragraph and first fenced `swift` block.
4. Add `captures/manifest.json`, initially `{ "captures": [] }`.
5. Run `npm run sync`, then `npm run build`, and build the Atlas scheme in Xcode.

```yaml
---
id: example-id
title: Example title
summary: What this example helps someone understand.
category: Presentation
family: Popovers
order: 10
kind: native
demoMinIOS: "18.0"
swiftFile: ExampleDemo.swift
view: ExampleDemo
apis: [popover]
tags: [adaptive, sizing]
---
```

IDs, Swift filenames, and view names must be unique. Prefer one small concept with useful controls over several nearly identical entries. Keep code in the Swift file; the website displays that exact file. Use Markdown-relative links for screenshots and source so the README remains useful on GitHub.

Keep the short snippet self-contained and focused on the essential API. The full demo stays available in a collapsed disclosure. Avoid walkthroughs, observation lists, comparison checklists, and promotional sidebars on the website.

The first collection uses `Presentation`; adding another category also requires extending the website's category navigation and source-loader paths. Keep the first release deliberately scoped until the entry format has been reviewed.

## Capture a presentation

Run `AtlasUITests.testCaptureAlerts` on the desired simulator. It launches the two alert entries through `--entry <id> --capture` and stores a screenshot attachment named `atlas--<id>--clean`. Capture mode presents the actual system alert on an empty light screen with Large text, hiding navigation, status bar, and demo controls. Normal app launches retain the interactive controls.

The planned comparison set is **iOS 18, iOS 26, and iOS 27**. Keep source, state, appearance, locale, and text size consistent, and record device differences. Only iOS 27 alerts are captured for the current review; the iOS 18/26 runs and other presentations remain future work.

Use `framing: "isolated"` in capture import metadata for these clean scenes. The website centers the presentation in a square preview; clicking it opens the unedited full-screen PNG. Use `framing: "screen"` for examples where the surrounding interface matters.

Export attachments with Xcode's `xcresulttool`:

```sh
xcrun xcresulttool export attachments --path /path/to/TestResults.xcresult --output-path work/exported-captures
```

Use the capture importer described by `node scripts/import-captures.mjs --help`. Supply the actual device, runtime, SDK, and settings for that run. The importer saves original PNGs under the entry, updates its provenance manifest, and adds normal Markdown image links. Review every imported image before committing it.

Use a fixed appearance, locale, and text size for comparisons. Record accessibility variants as separate captures. Do not relabel a screenshot as a different OS, silently replace historical captures, or infer runtime behavior from SDK availability. If code changed after a capture, regenerate it or preserve the original source revision.

## Checks

- `npm run validate`: metadata, unique IDs, local links, source references, and capture provenance.
- `npm run build`: validation, Astro type checks, static rendering, and Pagefind indexing.
- Xcode Product → Test: meaningful interaction checks and repeatable capture scenarios.
- Visually inspect a phone layout, a wide layout, and at least one example detail page on the website.

Generated outputs in `work/`, `website/dist/`, and `website/.astro/` are ignored. Generated app registration and source symlinks are tracked so a fresh checkout can open in Xcode immediately.

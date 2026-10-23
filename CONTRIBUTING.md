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

Categories and source paths are discovered from the catalog automatically. Adding a collection does not require editing website navigation.

## Capture a presentation

Run `npm run sync`, then select the generated `CatalogCaptureTests` for the desired examples and simulators in Xcode. Each test launches `--entry <id> --capture` and stores an attachment named `atlas--<id>--default`. Capture mode hides unrelated demonstration controls and uses light appearance with Large text. Normal launches retain the interactive controls.

The comparison set is **iOS 18, iOS 26, and iOS 27**, where the API and simulator support the example. Keep source, state, appearance, locale, and text size consistent, and record device differences. Use the actual point-release version, not only its generation. Do not automatically open camera, microphone, purchase, or account flows while collecting screenshots.

Use `framing: "isolated"` only for centered alerts. The website centers the presentation in a square preview; clicking it opens the unedited full-screen PNG. Sheets, anchored popovers, and full interfaces use `framing: "screen"`.

For a repeatable command-line run, list available devices with `xcrun simctl list devices available`, then run:

```sh
node scripts/capture-catalog.mjs --devices <simulator-UUIDs> \
  --entries alert-actions,alert-text-fields --output work/alert-comparison
```

Comma-separate device UUIDs. The runner records runtime metadata and source hashes before building, exports attachments, and leaves import as a separate review step. Its environment JSON lets the importer reject captures if the source has changed since the run. Keep the catalog frozen while the runner is active.

You can also export attachments from an Xcode test run with `xcresulttool`:

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

## Collections and availability

Use a unique kebab-case entry ID and Swift filename across the catalog. `category` groups the app and website; `order` places entries within the overall catalog. `demoMinIOS` is the actual minimum runtime, and sync generates the corresponding availability guard.

Set `captureNavigation: true` when the subject needs the app's outer navigation stack. Set it to `false` for isolated presentations or examples that own a navigation container. Set `ownsNavigation: true` only for the latter; the normal app then provides a separate route back to Atlas. Capture mode omits that catalog control.

A capture-ready example responds to `--entry <id> --capture`, exposes `capture-ready` on its rendered subject, and uses deterministic sample data. `npm run sync` generates a native XCTest per entry. Unsupported runtimes are skipped. Run the selected `CatalogCaptureTests` on iOS 18, 26, and 27, export the attachments, and import them with the existing importer. Use `captureStyle: isolated` only for centered alerts that can safely be previewed in a square; sheets, anchored popovers, and full interfaces use `screen`.

Compare the original images before committing. For split views, sidebars, inspectors, and adaptive popovers, also record a wide iPad capture. A screenshot documents a specific state; it does not prove an animation, gesture, or accessibility behavior.

For a large comparison run, `node scripts/sync-capture-tests.mjs --skip-existing` generates tests that skip OS generations already captured from the same Swift source hash. Regenerate with `npm run sync` afterward to restore normal tests. This optimization is for iPhone-only runs and only uses existing iPhone captures. Generate the normal tests before running iPad or Duo-specific comparisons.

Native menus can declare `captureAction: tap` or `longPress`, with `capture-open` on their real trigger. `captureReadyLabel` waits for a system action whose identifier is not preserved. Keyboard subjects declare `captureKeyboard: true` and put `capture-focus` on the editable field; the harness checks for an already-visible software keyboard before tapping and asserts the real software keyboard is visible.

Use `captureScroll: true` when the initial subject requires an actual upward scroll. `captureState` describes the recorded state, and `captureEnvironmentNotes` records local locale, direction, or display overrides without changing device settings.

Set `captureManual: true` with `captureManualReason` for system surfaces that cannot be truthfully recorded inside the app, such as installed widgets. The generated test skips them rather than treating an app preview as a Home Screen capture.

StoreKit entries use `captureStoreKit: true` and the shared local fixture described in [the StoreKit guide](catalog/purchases/STOREKIT.md). Run those tests serially. The harness loads fictional product metadata and waits for `storekit-products-loaded`; it never taps purchase, restore, management, or redemption actions.

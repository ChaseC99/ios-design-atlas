# iOS Design Atlas

A visual reference for native iOS interfaces: runnable SwiftUI examples, brief Markdown descriptions and Swift recipes, and original simulator captures.

Browse [the catalog index](CATALOG.md) for focused collections of native interface examples. Each entry has a runnable SwiftUI demo, a short recipe, and original simulator captures as they are verified. [The roadmap](ROADMAP.md) tracks the full catalog scope and remaining work.

## Run the website

Requires Node.js 22.12+ (Node 24 recommended).

```sh
npm ci
npm run dev
```

Open the localhost URL printed by Astro. Search by pattern, API, or topic and filter by collection.

```sh
npm run build     # validate the catalog, type-check, build, and index search
npm run preview --workspace website
```

Astro reads Markdown, Swift source, and captures directly from `catalog/`. Pagefind indexes the generated entry pages. Development search also works without a Pagefind build.

## Run the app

```sh
npm run sync
open app/Atlas/Atlas.xcodeproj
```

Select the **Atlas** scheme and an iPhone or iPad simulator, then Run. Build with Xcode 27.1 or later. The deployment target is iOS 18.0; newer APIs are guarded at runtime. A development team is only needed when running on a physical device.

The app groups entries by collection and searches their titles, topics, and API names. Newer APIs show their minimum iOS version. Each demo exposes its own options and uses real system presentations. No network services or accounts are required.

For a direct launch during debugging:

```sh
xcrun simctl launch booted com.chase.Atlas --entry alert-actions
```

## Repository structure

```text
app/Atlas/                Xcode project, app shell, and native tests
catalog/<collection>/     One folder per example: README, Swift, captures
website/                  Astro templates, styles, and search
scripts/                  Catalog synchronization, validation, capture import
```

Each entry's Markdown frontmatter is the source for its ID, title, summary, API names, and app destination. `npm run sync` generates the app registry and relative symlinks to the original Swift files. The app compiles those files directly. Capture originals are stored once, next to their entry; optimized website images are disposable build outputs.

## First collection

| Example | Focus |
| --- | --- |
| [Alert actions](catalog/presentation/alert-actions/README.md) | Action counts, roles, cancellation |
| [Alert text fields](catalog/presentation/alert-text-fields/README.md) | Draft editing, validation, keyboard |
| [Confirmation dialogs](catalog/presentation/confirmation-dialogs/README.md) | Contextual actions and adaptation |
| [Popover anchors](catalog/presentation/popover-anchors/README.md) | Attachment, requested arrow edge, sizing |
| [Popover adaptation](catalog/presentation/popover-adaptation/README.md) | Automatic versus explicit compact behavior |
| [Popover content](catalog/presentation/popover-content/README.md) | Navigation, lists, and forms |
| [Inspectors](catalog/presentation/inspectors/README.md) | Compact sheets and trailing columns |
| [Source transitions](catalog/presentation/source-transitions/README.md) | Default presentation versus a source-linked zoom |
| [Long text & accessibility](catalog/presentation/presentation-stress-tests/README.md) | Long messages, German sample labels, accessibility checks |

## Captures and verification

The comparison set is **iOS 18, 26, and 27**, using available point releases. The catalog index shows exactly which captures exist; missing images remain pending. Alerts use an empty presentation screen. Other examples retain the native bars, content, or keyboard needed to understand the component. Clicking a preview opens the original full-screen PNG.

Every capture has a neighboring `captures/manifest.json` recording its device, exact OS/build, build SDK, Xcode version, appearance, text size, locale, scenario, timestamp, and source SHA-256. Local environment overrides are recorded separately. Different device models and SDK versions are identified so comparisons are not mistaken for controlled same-device or older-SDK builds.

Run the native tests in Xcode with **Product → Test**. `AtlasBehaviorTests` covers sheet editing and dismissal, navigation, restored paths, and independent tab stacks. Generated `CatalogCaptureTests` records one deterministic native state per supported entry. Wide layouts also need iPad or Duo captures; still images do not verify motion, pointer behavior, or assistive technologies. See [CONTRIBUTING.md](CONTRIBUTING.md) for the capture workflow and entry format.

## Current scope

- Native SwiftUI demonstrations with an iOS 18 baseline.
- A static Astro catalog, with no backend or media duplication.
- Screenshots document appearances; source transitions should also be inspected in the app.
- The German example uses explicit sample strings. It does not represent a fully localized app.
- SDK and OS versions are tracked separately. Different device models are identified so their captures are not mistaken for a controlled same-device comparison.

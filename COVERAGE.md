# Catalog coverage audit

Historical scope audit from 2026-10-23T14:56:40.295Z of original ROADMAP categories 1–30 and 34–35. Counts, capture gaps, and test outcomes below describe that snapshot unless explicitly updated. Categories 31–33 were excluded.

This is a dated scope audit. Current entry and capture totals are in [CATALOG.md](CATALOG.md); later verification is recorded in commit history and capture manifests.

## Evidence boundaries

There are **263 published entries in scope** (265 total at this snapshot), **78 imported captures**, and **56 entries with at least one imported capture**. All referenced PNGs exist and all imported source hashes match the current canonical demo source at this snapshot. This verifies provenance consistency, not visual quality or interaction correctness.

Sources inspected: ROADMAP.md; canonical catalog README metadata, first recipes and demo source; capture manifests; targeted runtime-sensitive source; AtlasBehaviorTests.swift and AtlasUITests.swift; behavior-matrix-summary.json, duo-summary.json, first-27-summary.json and navigation-repair.xcresult. The current inventory is generated in [CATALOG.md](CATALOG.md) with `npm run sync`. Raw exports and unfinished xcresult bundles are not counted as imported or approved captures. Concurrent publishing/capture work may advance these numbers.

“Implemented” below means a self-contained source/recipe entry exists for the grouped subject. It does not mean all original bullets are finished. Earlier standalone checks did not all enable MemberImportVisibility; the parent found and repaired missing Combine imports in three media/map demos during integration. The newest full-app build result must be checked separately. No builds/tests/simulators were run by this audit.

## Imported capture inventory at audit snapshot

| Roadmap | Collection | Entries | Captures | Entries captured | Runtime versions |
|---|---|---:|---:|---:|---|
| 1 | Sheets | 12 | 26 | 12 | 18.5, 26.5, 27.0 |
| 2 | Presentation | 9 | 17 | 9 | 18.5, 26.5, 27.0 |
| 3 | Navigation | 8 | 7 | 7 | 27.0 |
| 4 | Tabs | 8 | 7 | 7 | 27.0 |
| 5 | Toolbars | 8 | 0 | 0 | Pending |
| 6 | Scrolling | 8 | 0 | 0 | Pending |
| 7 | Scroll edges | 8 | 5 | 5 | 27.0 |
| 8 | Materials | 8 | 8 | 8 | 27.0 |
| 9 | Lists | 8 | 0 | 0 | Pending |
| 10 | Grids | 8 | 0 | 0 | Pending |
| 11 | Buttons | 8 | 0 | 0 | Pending |
| 12 | Controls | 8 | 0 | 0 | Pending |
| 13 | Text input | 9 | 0 | 0 | Pending |
| 14 | Search | 10 | 0 | 0 | Pending |
| 15 | Typography | 9 | 0 | 0 | Pending |
| 16 | Visuals | 8 | 0 | 0 | Pending |
| 17 | Layout | 8 | 0 | 0 | Pending |
| 18 | Animation | 8 | 0 | 0 | Pending |
| 19 | Gestures | 8 | 0 | 0 | Pending |
| 20 | Accessibility | 9 | 0 | 0 | Pending |
| 21 | Localization | 6 | 0 | 0 | Pending |
| 22 | Device adaptation | 8 | 8 | 8 | 27.1 |
| 23 | Wide layouts | 6 | 0 | 0 | Pending |
| 24 | States | 8 | 0 | 0 | Pending |
| 25 | Forms | 9 | 0 | 0 | Pending |
| 26 | Media & drawing | 8 | 0 | 0 | Pending |
| 27 | Maps | 6 | 0 | 0 | Pending |
| 28 | Charts | 10 | 0 | 0 | Pending |
| 29 | Integrations | 8 | 0 | 0 | Pending |
| 30 | Privacy | 6 | 0 | 0 | Pending |
| 34 | Custom patterns | 10 | 0 | 0 | Pending |
| 35 | Versions & interop | 8 | 0 | 0 | Pending |

Imported coverage details: Presentation has four entries on all three versions (alert-actions, alert-text-fields, confirmation-dialogs, presentation-stress-tests), and five only on 27.0. Sheets has all twelve on 26.5/27.0, with sheet-keyboard and sheet-full-screen additionally on 18.5. Navigation lacks navigation-bar-appearance; Tabs lacks tab-bottom-accessory; their others are only on 27.0. Scroll edges lacks the repaired scroll-edge-styles, full-bleed-safe-areas and keyboard-safe-areas captures. Device adaptation captures are on 27.1 in the initial closed Duo posture only.

Most imported captures use light appearance, en_US and Dynamic Type Large (the default category, not the largest accessibility size). The requested matrix of dark/contrast/transparency, accessibility sizes, RTL, landscape/wide windows and before/during/after/cancelled interaction is not complete.

## Interaction evidence

- The three sheet behavioral tests (detent content expansion/collapse; cancel preserving saved title; save persisting across presentations) passed on 18.5, 26.5 and 27.0 in the reviewed behavior matrix. Four capture tests also passed on each; those are not four additional behavioral proofs.
- The same matrix had three navigation/tab selector failures per runtime. A newer navigation-repair.xcresult on iOS 27.0 passed deep-link recovery and independent tab stacks, but failed push/pop recovery at “Return to Journeys.” Do not extend these newer passes to 18.5/26.5.
- The Duo result recorded 9 passes and 2 failures among 11 tests; imported captures establish eight closed-posture appearances. Navigation/tab failures are not evidence that folding was tested.
- Historical first-27 capture failures for confirmation-dialogs and presentation-stress-tests have newer imported captures. Retain provenance but do not treat the historical failures as current blockers.
- The behavior matrix also recorded three “Invalid frame dimension (negative or non-finite)” warnings. This audit did not establish source attribution. navigation-repair had no runtime warnings.
- Screenshot readiness, a tap that opens a presentation, successful compilation, and accessibility modifiers are different evidence from a completed behavior assertion. No motion, VoiceOver, Voice Control, Switch Control, IME, haptic, Pencil-pressure or real multiwindow check is established by this audit.

## Collection mapping and remaining original scope

### 1. Sheets

**Entries:** `sheet-basics`, `sheet-detents`, `content-sized-sheets`, `sheet-appearance`, `sheet-background-interaction`, `sheet-scrolling`, `sheet-dismissal`, `sheet-keyboard`, `sheet-navigation`, `sheet-full-screen`, `sheet-source-zoom`, `sheet-adaptation`.

**Runnable source coverage:** Native sheet sizing, all requested detent families and selected-detent binding, appearance, background interaction, scroll preference, draft dismissal, keyboard, nested navigation/presentation, full-screen handoff, source zoom, compact adaptation.

**Uncovered or incomplete original scope:** Duo fold-aware placement is not demonstrated. Compact/regular-width and source-motion comparisons are not complete.

**Interaction evidence:** Detent expansion/collapse and draft cancel/save persistence passed on 18.5, 26.5 and 27.0 in the behavior matrix. Swipe dismissal, background taps, nested presentation, scrolling arbitration and animation cancellation still need interaction checks.

**Hardware/setup limits:** Regular-width iPad and actual Duo posture changes are needed; keyboard captures require the software keyboard.

### 2. Presentation

**Entries:** `alert-actions`, `alert-text-fields`, `confirmation-dialogs`, `popover-anchors`, `popover-adaptation`, `popover-content`, `inspectors`, `source-transitions`, `presentation-stress-tests`.

**Runnable source coverage:** Alert roles/action counts, text fields, confirmation ordering, anchored/adaptive popovers, navigation/list/form popovers, inspectors, source zoom and long/localized text stress controls.

**Uncovered or incomplete original scope:** No major grouped source omission identified. A phone inspector capture does not establish the side-panel appearance; the full large-type/localized-label matrix is absent.

**Interaction evidence:** Alert save/cancel and popover reopen tests are authored in AtlasUITests.swift; this audit did not establish their latest execution outcomes. Source-transition motion and arrow/dismissal behavior are not proved by captures.

**Hardware/setup limits:** Regular-width popovers/inspectors need iPad or wide-window runs.

### 3. Navigation

**Entries:** `navigation-push-pop`, `navigation-title-styles`, `navigation-title-menu`, `navigation-path-restoration`, `navigation-bar-appearance`, `navigation-image-header`, `navigation-scroll-restoration`, `navigation-destination-states`.

**Runnable source coverage:** Push/pop, title styles and menus, subtitles with guards, typed deep links/path storage, bar appearance, artwork headers, scroll restoration and unavailable/loading destinations.

**Uncovered or incomplete original scope:** A focused back-button-title/appearance comparison is missing. Interactive-back cancellation and persisted restoration after relaunch are not established.

**Interaction evidence:** Latest reviewed iOS 27 repair result passes deep-link recovery but still fails push/pop recovery at “Return to Journeys.” Earlier 18.5/26.5 tests failed initial selectors; do not mark them verified.

**Hardware/setup limits:** Review the remaining test failure before diagnosing native navigation itself; a selector failure alone is not proof of an app bug.

### 4. Tabs

**Entries:** `standard-tabs`, `tab-navigation-stacks`, `search-tab`, `minimizing-tab-bars`, `tab-bottom-accessory`, `sidebar-adaptable-tabs`, `two-column-navigation`, `three-column-navigation`.

**Runnable source coverage:** Labels/badges/selection, independent stacks and reselection binding, search role, minimization, inline/expanded bottom accessories, sidebar customization and two/three-column splits.

**Uncovered or incomplete original scope:** No major grouped source omission identified. Wide sidebar customization, split collapse/expansion and accessory states lack a completed comparison matrix.

**Interaction evidence:** Latest reviewed iOS 27 repair result passes independent stacks. Earlier 18.5/26.5 runs failed; tab reselection, minimization gestures and customization persistence need explicit checks.

**Hardware/setup limits:** Regular-width iPad and scrolling/motion checks are needed.

### 5. Toolbars

**Entries:** `toolbar-placements`, `toolbar-groups`, `toolbar-action-roles`, `toolbar-menus`, `selection-toolbars`, `keyboard-toolbars`, `toolbar-overflow`, `toolbar-minimization`.

**Runnable source coverage:** Leading/trailing/bottom/keyboard placements, grouping/spacers, action roles, menus, selection-dependent actions, overflow priority and minimization/restoration.

**Uncovered or incomplete original scope:** Explicit horizontal-versus-vertical toolbar configuration comparisons are absent. Long/crowded controls are configured but overflow states are not validated.

**Interaction evidence:** No behavioral test outcome reviewed. Keyboard capture readiness is a specific risk below.

**Hardware/setup limits:** Toolbar grouping requires 26; priority/minimization examples use 27. Hardware keyboard is needed for shortcut/discoverability checks.

### 6. Scrolling

**Entries:** `nested-scrolling`, `scroll-snapping`, `scroll-position`, `bottom-anchored-chat`, `preserving-scroll-target`, `scroll-bounce-indicators`, `refresh-and-pagination`, `pinned-headers-scroll-effects`.

**Runnable source coverage:** Nested vertical/horizontal shelves, paging/view alignment, edge/item/offset position, initial/bottom anchors, insertion preservation, bounce/indicators, refresh/pagination, keyboard dismissal and pinned/scroll effects.

**Uncovered or incomplete original scope:** System status-bar scroll-to-top is not separately demonstrated or tested (programmatic top scrolling exists). Indicator-margin treatment lives in Scroll edges.

**Interaction evidence:** No behavioral test outcome reviewed; chat following, insertion stability, interrupted refresh and gesture arbitration remain unverified.

**Hardware/setup limits:** Motion and real input checks are required; local delayed fixtures are not network loading evidence.

### 7. Scroll edges

**Entries:** `scroll-edge-styles`, `scroll-edge-visibility`, `safe-area-actions`, `safe-area-bars`, `scroll-content-margins`, `full-bleed-safe-areas`, `keyboard-safe-areas`, `background-extension`.

**Runnable source coverage:** Automatic/hard/soft styles, visibility on multiple edges, system/custom bars, safe-area insets/bars, content/indicator margins, full bleed, keyboard avoidance and background extension.

**Uncovered or incomplete original scope:** Actual photographs/video beneath edge effects and a focused nested-container inset comparison are missing. Pinned-header effects are partly covered in Scrolling but not a complete edge-style matrix.

**Interaction evidence:** Five imported resting captures; three repaired entries await import. Earlier visual QA found and repaired full-bleed contrast. No scrolling or keyboard interaction outcomes reviewed here.

**Hardware/setup limits:** 26-only APIs need guards. Background extension requires a regular-width comparison to show the sidebar treatment.

### 8. Materials

**Entries:** `system-materials`, `material-versus-opacity`, `glass-variants`, `glass-shapes`, `glass-containers`, `glass-morphing`, `glass-backgrounds`, `adaptive-material-fallback`.

**Runnable source coverage:** System materials, opacity comparison, regular/clear/tinted/interactive glass, shapes, containers/unions, morphing, layered/busy/moving backgrounds and older-OS fallback.

**Uncovered or incomplete original scope:** Real photographic/video backgrounds are absent; existing fixtures use original gradients/artwork. No major remaining API grouping omission identified.

**Interaction evidence:** Eight imported resting 27.0 captures. Joining/morphing/touch response and actual accessibility-setting changes are not validated by them.

**Hardware/setup limits:** Increase Contrast, Reduce Transparency and Reduce Motion need real environment variants. Glass requires 26.

### 9. Lists

**Entries:** `list-styles`, `list-row-anatomy`, `list-selection`, `list-swipe-actions`, `list-editing-reordering`, `list-outline-hierarchy`, `list-section-index`, `list-animated-updates`.

**Runnable source coverage:** Styles, row anatomy/sections, selection, edit/batch actions, swipe/delete/reorder, outlines, indexes and animated conditional updates.

**Uncovered or incomplete original scope:** A substantial long image-loaded list with mixed heights is not a dedicated stress case; current thumbnail content is generated/system imagery.

**Interaction evidence:** No behavioral test outcome reviewed; full swipe, drag reorder, selection and updates need checks.

**Hardware/setup limits:** Section-index API needs its 26 guard; real image-loading stress needs fixtures.

### 10. Grids

**Entries:** `grid-column-sizing`, `grid-alignment-spanning`, `grid-selection`, `card-carousels`, `grid-detail-transitions`, `reorderable-grid`, `wrapping-chip-layout`, `masonry-grid-layout`.

**Runnable source coverage:** Fixed/flexible/adaptive columns, alignment/spanning, card anatomy and selection, carousels/indicators, detail transitions, reordering, wrapping and masonry.

**Uncovered or incomplete original scope:** The photo-grid visual fixtures are artwork, not actual photographs. Real selected photos are separately available through PhotosPicker.

**Interaction evidence:** No behavioral test outcome reviewed; drag reorder, transition cancellation and across-width stability need checks.

**Hardware/setup limits:** Wide-window, empty/partial and large-type variants remain capture work.

### 11. Buttons

**Entries:** `button-styles`, `button-labels`, `button-states`, `repeating-buttons`, `menus`, `menu-primary-actions`, `context-menus`, `custom-button-styles`.

**Runnable source coverage:** Built-in/custom styles, sizes/label shapes, hierarchy, selected/disabled/loading/success, repeat, nested/primary-action menus, context previews and multi-selection.

**Uncovered or incomplete original scope:** Hit-region comparison additionally lives in Custom patterns. No other major grouped source omission identified.

**Interaction evidence:** No behavioral test outcome reviewed. Static buttons do not prove press/repeat/context-menu behavior or custom-style accessibility.

**Hardware/setup limits:** Real long press and accessibility activation checks are needed.

### 12. Controls

**Entries:** `picker-styles`, `toggle-styles`, `sliders-and-steppers`, `date-picker-styles`, `date-selection`, `color-pickers`, `choice-chips`, `rating-controls`.

**Runnable source coverage:** Picker styles and long labels, toggles, continuous/stepped sliders, stepper, date/time/range/multiple dates, colors, custom ratings/chips and single/multi-selection.

**Uncovered or incomplete original scope:** Explicit non-Gregorian calendar comparison is not established; locale/time-zone controls do not by themselves prove it.

**Interaction evidence:** No behavioral test outcome reviewed; value changes, endpoint feedback and custom adjustable behavior need checks.

**Hardware/setup limits:** Time-zone/calendar/locale and hardware keyboard variants remain.

### 13. Text input

**Entries:** `text-field-styles`, `secure-field-visibility`, `multiline-text-fields`, `text-editor-selection`, `rich-text-editing`, `keyboard-focus-flow`, `formatted-text-input`, `inline-form-validation`, `keyboard-safe-area`.

**Runnable source coverage:** Field styles/labels, secure visibility, multiline/editor/rich text, selection, focus/submit/toolbars, validation/counts/adornments and keyboard avoidance.

**Uncovered or incomplete original scope:** Phone keyboard/content-type hints are not a phone-number formatter. Date-formatted TextField and search-within-form are not dedicated samples. Actual autofill/OTP, dictation, paste and IME sequences are unverified.

**Interaction evidence:** No behavioral test outcome reviewed beyond separate sheet draft tests. Editing handles, focus traversal and keyboard avoidance need runtime checks.

**Hardware/setup limits:** Rich text requires 26. Real hardware keyboard, international IMEs and configured autofill/OTP sources are necessary.

### 14. Search

**Entries:** `search-placement-activation`, `search-suggestions-history`, `search-scopes`, `search-tokens`, `search-filters`, `search-result-states`, `search-highlighting-groups`, `search-navigation-state`, `split-view-search`, `keyword-search-phrases`.

**Runnable source coverage:** Placement/activation, suggestions/history, scopes/tokens, filter summaries, result states, highlights/groups, collection navigation, split search and local phrase matching.

**Uncovered or incomplete original scope:** Voice input is missing. Keyword phrase matching is a deterministic local matcher, not a natural-language service/model.

**Interaction evidence:** No behavioral test outcome reviewed; focus/cancel, state preservation and token editing need checks.

**Hardware/setup limits:** Wide split layouts and keyboard/voice input require separate runs.

### 15. Typography

**Entries:** `system-text-styles`, `font-design-weight-width`, `dynamic-type-readable-width`, `text-wrapping-truncation`, `text-spacing-baselines`, `attributed-text-markdown`, `numbers-dates-timers`, `expandable-selectable-text`, `rich-text-editor`.

**Runnable source coverage:** Text styles, weight/width/design, scaled custom-font API, readable width, wrapping/scaling, spacing/baselines, attributed/Markdown links, timers/numbers, selectable/expandable text and rich formatting.

**Uncovered or incomplete original scope:** Uses bundled Georgia rather than a bundled third-party font asset; installing and configuring an actual custom font remains a distinct example gap.

**Interaction evidence:** No behavioral test outcome reviewed. Capture mode freezes timers; a screenshot cannot verify live updates or editor selection.

**Hardware/setup limits:** Largest accessibility sizes, wide readable width, font fallback and actual link/selection interactions need checks.

### 16. Visuals

**Entries:** `symbol-rendering-modes`, `symbol-variants-alignment`, `variable-symbols-effects`, `semantic-colors-contrast`, `gradients-and-mesh`, `image-fitting-avatars`, `concentric-shapes`, `masks-blending-overlays`.

**Runnable source coverage:** Symbol rendering/variants/alignment/variable effects, semantic/contrast color, gradients/mesh, fit/fill/avatars, concentric shapes, borders/shadows/masks/blending.

**Uncovered or incomplete original scope:** Custom SF Symbol asset and app-icon appearance variants are absent. Photo fixtures are original rendered artwork.

**Interaction evidence:** No behavioral test outcome reviewed; symbol replacement/motion is not proved by resting captures.

**Hardware/setup limits:** Concentric API requires 26; system contrast/dark mode and actual asset variants need explicit coverage.

### 17. Layout

**Entries:** `stack-alignment`, `flexible-frames`, `layout-insets`, `overlays-and-modifier-order`, `adaptive-composition`, `layout-switching`, `wrapping-layout`, `geometry-and-aspect`.

**Runnable source coverage:** Alignment/baselines, frames/priorities, padding/insets, modifier order, overlay versus stacks, ViewThatFits, AnyLayout, wrapping/custom layout and geometry/aspect/readable widths.

**Uncovered or incomplete original scope:** No major grouped source omission identified; cross-product stress combinations remain.

**Interaction evidence:** No behavioral test outcome reviewed. Width changes and layout-transition continuity require interaction checks.

**Hardware/setup limits:** Largest text sizes, RTL, narrow/wide windows and long content must be exercised.

### 18. Animation

**Entries:** `animation-curves`, `view-transitions`, `matched-geometry`, `content-and-symbol-transitions`, `phase-and-keyframe-animation`, `gesture-driven-motion`, `animation-completion`, `navigation-zoom`.

**Runnable source coverage:** Curves/springs, explicit/implicit changes, symmetric/asymmetric transitions, matched geometry, content/symbol transitions, phase/keyframes, gesture motion, completion/chaining and zoom.

**Uncovered or incomplete original scope:** No major grouped source omission identified. Loading/success/error and layout animation also appear in other collections.

**Interaction evidence:** No motion verification outcome reviewed. Interrupted/reversed animation, completion sequencing and reduced-motion behavior remain explicit gaps in validation.

**Hardware/setup limits:** Record or interact with the actual animation; static captures establish appearance only.

### 19. Gestures

**Entries:** `tap-and-press`, `simultaneous-transforms`, `scroll-and-swipe-gestures`, `scrubbing-control`, `drag-previews-and-drops`, `reordering-and-insertion`, `multi-item-dragging`, `sensory-feedback`.

**Runnable source coverage:** Tap/double tap/press, drag/transform combinations, scrolling swipe controls, scrubbing, native previews/drop insertion/reorder, multi-item drag and sensory feedback.

**Uncovered or incomplete original scope:** Cross-app drag and cancellation/interruption scenarios are not verified. Direction checks in a custom drag do not prove native scroll arbitration.

**Interaction evidence:** No behavioral test outcome reviewed. GestureState is used in examples but its presence is not proof of every cancellation path.

**Hardware/setup limits:** Multi-item dragging requires 27; real hardware is needed for haptics and practical external-app drop tests.

### 20. Accessibility

**Entries:** `dynamic-type-layouts`, `accessible-labels-groups`, `accessibility-custom-actions`, `accessible-adjustable-controls`, `accessibility-focus-announcements`, `contrast-transparency-adaptation`, `reduced-motion-adaptation`, `accessible-input-controls`, `accessible-data-summaries`.

**Runnable source coverage:** Dynamic Type/Bold Text, labels/values/groups, named actions/adjustable controls, focus/announcements, contrast/transparency/motion alternatives, input targets and data summaries.

**Uncovered or incomplete original scope:** Button Shapes and On/Off Labels variations are missing. Captioned/transcribed media is missing. General ordinary-entry accessibility variation matrix is incomplete.

**Interaction evidence:** No VoiceOver, Voice Control, Switch Control or assistive keyboard outcomes reviewed. Declared modifiers and static screenshots must not be called assistive-behavior validation.

**Hardware/setup limits:** Manual assistive-technology sessions, largest type sizes and actual system settings are required.

### 21. Localization

**Entries:** `right-to-left-layout`, `localized-text-expansion`, `mixed-direction-content`, `localized-value-formats`, `grammatical-plural-agreement`, `international-script-input`.

**Runnable source coverage:** RTL/mirroring, expansion, mixed direction, localized numeric/date/currency/measurement formats, grammatical agreement and international scripts/input fixtures.

**Uncovered or incomplete original scope:** This is a fixture/environment study, not a fully localized app/resource catalog. Plural-rule coverage beyond limited examples and combined tab/sheet/alert expansion remain incomplete.

**Interaction evidence:** No real IME or navigation-direction interaction outcome reviewed.

**Hardware/setup limits:** Real keyboards, language settings, non-Gregorian calendars and longer translations need checks.

### 22. Device adaptation

**Entries:** `split-arrangements`, `overlay-arrangements`, `arrangement-proportions`, `reserved-region-inspection`, `hinge-observation`, `size-class-and-geometry`, `resize-state-preservation`, `adaptive-media-composition`.

**Runnable source coverage:** Public 27.1 ArrangementView split/overlay/proportion APIs, reserved regions, hinge observation, geometry/size classes, resize state and adaptive media composition.

**Uncovered or incomplete original scope:** Missing actual outer/inner, fully open/partly folded comparisons; fold-driven navigation/scroll/selection preservation; fold-aware sheet/popover/menu/keyboard placement; older-SDK compatibility builds; Apple-app equivalents. Media composition is a visual playback study, not actual video.

**Interaction evidence:** Eight imported Duo captures show ONLY initial closed posture; manifest records hinge 0 degrees and no simulated pose change. They do not verify folding transitions.

**Hardware/setup limits:** Five native Duo examples require 27.1 (not 27.0) and are marked beta. Owned Duo simulator only; no simctl hinge operation established. Wide document/map examples exist elsewhere but lack Duo posture evidence.

### 23. Wide layouts

**Entries:** `wide-inspector-workspace`, `adaptive-content-density`, `pointer-keyboard-actions`, `drag-between-collections`, `wide-popover-adaptation`, `pencil-drawing-canvas`.

**Runnable source coverage:** Inspector workspace, content density/readable widths, hover/shortcuts, local collection drag, adaptive popover and native PencilKit canvas.

**Uncovered or incomplete original scope:** Multiple windows sharing content and drag between windows are missing (current drag is between local collections). Hardware-keyboard selection/editing is not established.

**Interaction evidence:** No completed regular-width or hardware interaction outcome reviewed. Phone captures cannot establish iPad sidebar/inspector layout.

**Hardware/setup limits:** iPad/wide resizable windows plus hardware keyboard, pointer and Pencil pressure are necessary.

### 24. States

**Entries:** `progress-and-cancellation`, `skeleton-and-redaction`, `empty-and-unavailable`, `recoverable-errors`, `partial-and-offline`, `background-refresh`, `optimistic-updates`, `success-and-undo`.

**Runnable source coverage:** Progress/cancel, skeleton/redaction, first-use/no-results empties, recoverable/partial/offline errors, background refresh, optimistic rollback and undo.

**Uncovered or incomplete original scope:** No major grouped visual-state omission identified. All service outcomes are explicit local fixtures, not real network/cache implementation.

**Interaction evidence:** No behavioral test outcome reviewed; cancellation, interruption, rollback and absence of layout jumps remain unverified.

**Hardware/setup limits:** Timing and interrupted task checks matter more than a static resting capture.

### 25. Forms

**Entries:** `settings-form`, `draft-editing-flow`, `conditional-validation-form`, `multi-step-setup`, `onboarding-preferences`, `profile-editing`, `batch-editing-recovery`, `import-progress-flow`, `filter-sort-sheet-flow`.

**Runnable source coverage:** Settings, draft save/cancel, conditional/required validation, multistep onboarding, profile editing, batch/destructive recovery, processing/import and filter/sort flow.

**Uncovered or incomplete original scope:** Import/processing is a local simulation rather than file decoding; account/profile edits are local fixtures. These limits should remain visible in the examples.

**Interaction evidence:** No dedicated form-flow result reviewed. Passing the separate sheet edit tests does not prove every form flow.

**Hardware/setup limits:** Backend/account integration is out of these local fixtures; keyboard, large-type and interrupted multistep sessions need checks.

### 26. Media & drawing

**Entries:** `system-photo-selection`, `artwork-gallery-transition`, `zoom-pan-artwork`, `native-video-player`, `local-audio-queue`, `microphone-recording-state`, `camera-capture-entry`, `artwork-markup-tools`.

**Runnable source coverage:** PhotosPicker single/multi selection, original artwork gallery/zoom/detail, real AVPlayer, local audio queue, manual microphone/camera controls and canvas annotations. PencilKit lives in Wide layouts; mini accessory in Tabs.

**Uncovered or incomplete original scope:** Missing actual photograph asset/loading/limited-library comparison; dedicated custom live camera preview; transcripts/captions; exported crop/markup pipeline. Changing canvas aspect ratio is not a crop editor. PiP is enabled but app/device configuration is not verified.

**Interaction evidence:** No media interaction outcome reviewed. First-video-frame readiness and interrupted annotation strokes are source-inspection risks below.

**Hardware/setup limits:** Original vector artwork, generated three-second silent H.264 movie and generated quiet WAV tones avoid asset licensing. Camera/mic need usage-description keys and physical capability; requests occur only after explicit user actions.

### 27. Maps

**Entries:** `map-styles-and-location`, `map-place-selection`, `map-route-overlays`, `map-local-search-results`, `map-movable-place-sheet`, `native-annotation-clustering`.

**Runnable source coverage:** Map styles/cameras, selected markers/cards, native clustering, illustrative polyline/polygon overlays, local result filtering, location control and movable detail sheet.

**Uncovered or incomplete original scope:** Service-backed search/directions/ETA summaries are absent. Hand-authored route is explicitly illustrative, not route guidance.

**Interaction evidence:** No behavioral test outcome reviewed for clustering, camera/selection sync or map/sheet gesture competition.

**Hardware/setup limits:** Map tiles may require network; region/coordinates/details are local. Real location needs configuration, permission and a fix; no automatic request.

### 28. Charts

**Entries:** `chart-mark-types`, `chart-selection`, `sector-chart-selection`, `scrolling-time-series`, `multi-series-chart`, `chart-data-edge-cases`, `live-chart-metrics`, `heatmap-table-chart`, `three-dimensional-charts`, `timeline-chart`.

**Runnable source coverage:** Mark families/axes/legends, x/angle selection, scrolling windows, multiple series, sparse/extreme data, live metrics/gauges, sortable table/heatmap, timeline and 3D.

**Uncovered or incomplete original scope:** No major grouped source omission identified. Meaningful comparison and accessible data semantics still need review with users/assistive tools.

**Interaction evidence:** No chart interaction outcome reviewed; scrubbing, live updates, sorting and 3D pose changes are not validated by screenshots.

**Hardware/setup limits:** 3D requires 26; VoiceOver/chart descriptors and dynamic updates need explicit interaction checks.

### 29. Integrations

**Entries:** `sharing-content`, `files-and-quick-look`, `native-web-presentation`, `composition-and-contacts`, `calendar-event-editor`, `scanning-and-printing`, `translation-and-writing-tools`, `tipkit-education`.

**Runnable source coverage:** ShareLink text/link/image/file; file import/export and Quick Look; embedded web/browser; mail/message/contact wrappers; event editor; scanning/printing; translation/Writing Tools; TipKit.

**Uncovered or incomplete original scope:** Dedicated document browser and DocumentGroup app-entry scene are absent. System-feature availability cannot be inferred from visible launch buttons.

**Interaction evidence:** Newly published; no capture or interaction outcome reviewed. All outbound/system flows are user-triggered, without automatic sending/printing.

**Hardware/setup limits:** Mail/SMS need configured capability; scanning needs supported camera hardware and usage key; translation/Writing Tools need system/device/language support. Embedded HTML is local; browser button may use network. Event editor on 17+ does not require reading calendars.

### 30. Privacy

**Entries:** `sign-in-with-apple`, `passkeys-and-passwords`, `biometrics-and-reauthentication`, `contextual-permissions`, `sensitive-content-reveal`, `local-account-and-data`.

**Runnable source coverage:** Native sign-in control/callbacks, passkey request path and password hints, LocalAuthentication session states, contextual permission states/recovery, sensitive reveal, local export/deletion.

**Uncovered or incomplete original scope:** Sign in with Apple is deliberately disabled without signing capability. Passkey request is deliberately disabled without relying party/associated domain/fresh backend challenge. These are setup-blocked flows, not completed sign-in demos. Local deletion is not real account deletion.

**Interaction evidence:** Newly published; no permission/authentication interaction outcome reviewed. Cancellation/failure handlers exist but have not been exercised across all states.

**Hardware/setup limits:** Real auth needs capability, service and credential verification; biometrics may need Face ID usage key. Permission buttons guard usage keys. privacySensitive is a hint, not screenshot prevention or secure storage.

### 34. Custom patterns

**Entries:** `expandable-trip-card`, `floating-creation-tray`, `undo-notice`, `growing-chat-composer`, `command-search-palette`, `day-plan-timeline`, `sliding-selection-indicator`, `swipeable-reading-cards`, `artwork-comparison-slider`, `plain-button-hit-area`.

**Runnable source coverage:** Ten original custom samples: expandable card, action tray, undo notice, growing chat, command palette, timeline, custom indicator, swipe cards, image comparison and contentShape discovery.

**Uncovered or incomplete original scope:** Native-looking custom bottom-sheet physics, interactive spotlight walkthroughs and shader rendering are missing. Native alternatives are explained; not every example has a live side-by-side implementation.

**Interaction evidence:** No runtime interaction outcome reviewed. Swipe-card interruption/retained-view risk below. Twenty demo/recipe standalone typechecks included MemberImportVisibility.

**Hardware/setup limits:** Exact Sarun source attribution retained for matched geometry and plain-button hit regions; no downloaded assets. Shader examples would need project-level setup.

### 35. Versions & interop

**Entries:** `uiview-binding-bridge`, `swiftui-in-uikit`, `hosting-configuration-cells`, `uikit-swiftui-controls`, `uikit-keyboard-boundary`, `presentation-control-environment`, `selectable-text-gesture-priority`, `runtime-control-baseline`.

**Runnable source coverage:** UIView binding coordinator, SwiftUI/UIKit embedding, hosting configurations, equivalent controls, keyboard boundary, presentation environment, text-gesture priority and runtime baseline.

**Uncovered or incomplete original scope:** Same-runtime/different-SDK builds, beta-to-release pairs, confirmed bug reproductions with demonstrated workarounds and retained fixed-regression captures are missing. A release-note candidate is not a reproduced bug.

**Interaction evidence:** No interop behavioral outcome reviewed. Existing imported runtime comparisons in other categories establish some appearance differences only, not motion or causality.

**Hardware/setup limits:** Current builds use SDK 27.1; running them on 18/26/27 does not constitute older-SDK compatibility testing. Exact build provenance must remain in manifests.

## Source-inspection risks and follow-up

These are targeted findings in this agent’s own frozen sources. They are not reproduced failures; no frozen source was changed.

1. **Swipe-card interruption.** Resolved in source after the audit: gesture-scoped translation and explicit cancellation reset. Manual interruption verification remains pending.
2. **Annotation cancellation.** Resolved in source after the audit: cancelled or disappearing gesture drafts clear. Manual interruption verification remains pending.
3. **Video capture readiness precedes visible media.** `catalog/media-drawing/native-video-player/NativeVideoPlayerDemo.swift:15` marks ready once an AVPlayer exists (assigned at line 36), not once the first frame is ready for display. The harness settlement delay may be adequate but is not a guarantee. A black/loading native player must be excluded if observed; use a first-frame readiness signal before recapture.
4. **Keyboard-toolbar capture may miss its defining UI.** The subsequent image review verified visible keyboard accessories on both iOS 18.5 and 26.5, while a readiness improvement remains useful.  `catalog/toolbars/keyboard-toolbars/KeyboardToolbarsDemo.swift:29` focuses after a fixed 300 ms while the form is immediately capture-ready. Unlike repaired keyboard-safe-areas, its README lacks captureKeyboard and the field lacks capture-focus. A screenshot can therefore pass readiness without showing a keyboard/accessory. Verify the actual PNG; use the harness focus/keyboard wait if missing.

## Checkpoint at audit snapshot

The catalog now has 263 grouped source examples in the audited collections, including newly published integration and privacy examples. 78 screenshots are imported with matching source provenance; most of the requested cross-version and device matrix is still pending. Three sheet behaviors have passing three-version checks, and two navigation/tab checks pass in the latest reviewed iOS 27 repair run. Setup-dependent authentication, real Duo posture changes, multiwindow/hardware interactions, accessibility sessions, older-SDK comparisons and several concrete content gaps remain. The catalog is broad in runnable source, but it is not yet exhaustive or fully validated.


## Verification after the audit snapshot

The integrated 271-entry app, UI-test target, and embedded WidgetKit extension build successfully with SDK 27.1 for arm64 and x86_64 simulators. The StoreKit fixture is present in the UI-test bundle. All three navigation/tab behavior checks pass on the actual iPhone Duo simulator (27.1, initial closed posture). Screenshot review excluded edit-menu overlays, two grid layout issues, image overflow, and inconsistent status-bar times before import. Current counts and individual source hashes are in CATALOG.md and the manifests. StoreKit activation, widget-system captures, and the unfinished scope above remain pending.

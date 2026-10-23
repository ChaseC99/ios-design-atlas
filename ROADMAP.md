# Catalog roadmap

This checklist preserves the original scope. Bullets can be grouped into focused runnable examples; an entry is finished only after its code and short recipe build, its meaningful interaction is checked, and supported iOS 18, 26, and 27 captures are recorded. Newer APIs must carry an availability guard. Platform-specific observations require evidence, not a simulated claim.

## Progress

- [CATALOG.md](CATALOG.md) is generated from the current entries and capture manifests, including exact version coverage.
- Presentation, Sheets, Navigation, Tabs, Toolbars, Scrolling, Scroll edges, Materials, Lists, Grids, Buttons, Controls, Text input, Search, Typography, Visuals, Layout, Animation, Accessibility, and Localization: runnable sources and standalone recipes type-check; the integrated app and website build. Native capture review continues.
- Device adaptation and Wide layouts: runnable examples are integrated. Five Duo APIs require iOS 27.1; older runtimes skip them. Actual posture and regular-width comparisons remain pending.
- Gestures, States, Forms, Charts, Media/drawing, and Maps: implementation in progress.
- Remaining collections: queued below. A runnable entry is not a claim that every related backlog bullet or interaction matrix is complete.
- Manual checks still needed include VoiceOver/Voice Control/Switch Control, IMEs, interrupted gestures, pointer/Pencil hardware, multiwindow behavior, and motion. Older-SDK comparisons require separate builds; changing only the simulator runtime cannot provide them.

Capture provenance lives beside each example. A missing capture is displayed as pending, and unsupported OS versions are never represented by fabricated screenshots. Static captures document appearance; motion and gesture behavior need a real interaction check.

## Original scope

1. **Sheets and modal presentation**

   - Default sheet appearance and sizing.
   - Medium and large presentation detents.
   - Fixed-height, fractional-height, and custom detents.
   - Changing the selected detent programmatically.
   - Content-sized sheets and resizing as content changes.
   - Drag indicator visibility and appearance.
   - Presentation corner radius.
   - Presentation backgrounds: system default, materials, colors, and custom views.
   - Background interaction while a sheet is open.
   - Scrolling versus resizing a sheet.
   - Interactive dismissal and preventing accidental dismissal.
   - Unsaved-changes confirmation.
   - Keyboard appearance inside a sheet.
   - Navigation stacks inside sheets.
   - Presenting a second sheet from an existing sheet.
   - Sheet-to-full-screen transitions and `fullScreenCover`.
   - Sheet presentations originating from a source view.
   - Sheet placement and fold avoidance on iPhone Duo.
   - Compact versus regular-width presentation.
   - Appearance comparisons across iOS versions.

2. **Alerts, confirmation dialogs, popovers, and inspectors**

   - Alerts with one, two, and multiple actions.
   - Destructive, cancel, and default action roles.
   - Alerts containing text fields.
   - Confirmation dialogs and action ordering.
   - Popover anchors, arrows, sizing, and dismissal.
   - Popover adaptation on compact screens.
   - Popovers containing navigation, lists, and forms.
   - Inspectors adapting between side panels and sheets.
   - Source-view presentation animations.
   - Long text, large type, and localized button labels.

3. **Navigation stacks and navigation bars**

   - Basic push and pop navigation.
   - Large titles, inline titles, and transitions between them.
   - Title alignment, wrapping, and truncation.
   - Navigation subtitles and title menus where supported.
   - Back-button titles and appearance.
   - Interactive back gestures and cancellation.
   - Programmatic navigation and deep-linked destinations.
   - Restoring a navigation path.
   - Navigation-bar visibility, backgrounds, tint, and color scheme.
   - Image headers beneath navigation bars.
   - Preserving scroll position when returning to a screen.
   - Loading or unavailable destinations.

4. **Tabs, sidebars, and split navigation**

   - Standard tab bars.
   - Tab labels, icons, badges, and selection.
   - Independent navigation stacks within tabs.
   - Tab reselection and returning to a section’s root.
   - Search tabs.
   - Tab-bar minimization while scrolling.
   - Bottom accessories such as mini players.
   - Expanded and collapsed accessory layouts.
   - Tab-to-sidebar adaptation.
   - Sidebar sections, selection, and customization.
   - Two-column and three-column navigation.
   - Split-view collapse, expansion, and empty detail states.

   Apple’s new-design walkthrough is a useful starting reference for floating tab bars, minimization, and bottom accessories. [Apple: Build a SwiftUI app with the new design](https://developer.apple.com/videos/play/wwdc2025/323/).

5. **Toolbars and persistent actions**

   - Leading, trailing, bottom, and keyboard toolbars.
   - Toolbar item placement and ordering.
   - Automatic grouping and shared backgrounds.
   - Separating groups with toolbar spacers.
   - Primary, secondary, destructive, and confirmation actions.
   - Icon-only versus labeled actions.
   - Toolbar menus and nested actions.
   - Overflow behavior and visibility priority.
   - Toolbar minimization and restoration.
   - Selection-dependent toolbars.
   - Horizontal versus vertical toolbars.
   - Long labels and crowded toolbars.

6. **Scrolling behavior**

   - Vertical and horizontal scrolling.
   - Nested scrolling and horizontal carousels.
   - Paging versus view-aligned snapping.
   - Scroll position and programmatic scrolling.
   - Initial scroll anchors.
   - Keeping the bottom anchored in chat or log views.
   - Preserving position when inserting content.
   - Scroll indicators and indicator margins.
   - Bounce behavior with short and long content.
   - Pull to refresh.
   - Pagination and loading additional content.
   - Keyboard dismissal while scrolling.
   - Sticky headers and pinned sections.
   - Scroll-driven visual effects.
   - Scroll-to-top behavior.

7. **Scroll edges, safe areas, and content margins**

   - `scrollEdgeEffectStyle`: automatic, hard, and soft.
   - Hiding scroll edge effects with `scrollEdgeEffectHidden`.
   - Top, bottom, and side-edge effects.
   - Effects behind standard bars versus custom controls.
   - Effects over text, photographs, gradients, and video.
   - Effects with pinned headers.
   - `safeAreaInset` and persistent action areas.
   - `safeAreaBar` behavior.
   - Content margins versus scroll-indicator margins.
   - Full-bleed backgrounds with inset content.
   - Keyboard safe areas.
   - Status-bar and home-indicator clearance.
   - Nested containers applying insets.
   - Background extension beneath surrounding interface elements.

   This category deserves especially thorough comparisons because automatic scroll-edge styling depends on platform and context. [Apple: ScrollEdgeEffectStyle](https://developer.apple.com/documentation/swiftui/scrolledgeeffectstyle?changes=_9).

8. **Liquid Glass, materials, and layering**

   - System materials and their visual differences.
   - Liquid Glass on custom views.
   - Regular and clear glass treatments where available.
   - Glass tinting.
   - Interactive glass behavior.
   - Glass shapes and clipping.
   - Multiple elements inside `GlassEffectContainer`.
   - Joining and separating glass elements.
   - Morphing between glass configurations.
   - Glass over light, dark, busy, and moving backgrounds.
   - Material versus opacity.
   - Overlapping translucent surfaces.
   - Readability with Increase Contrast and Reduce Transparency.
   - Older-OS fallback treatments.

9. **Lists, rows, and sections**

   - Plain, grouped, and inset-grouped list styles.
   - Section headers and footers.
   - Row backgrounds, insets, spacing, and separators.
   - One-line, two-line, and multiline rows.
   - Rows with icons, thumbnails, badges, and trailing values.
   - Disclosure rows and accessory controls.
   - Single and multiple selection.
   - Edit mode and batch actions.
   - Swipe actions and full-swipe behavior.
   - Deleting and reordering rows.
   - Expandable sections and outline hierarchies.
   - Section indexes.
   - Empty sections and conditional rows.
   - Insert, remove, and update animations.
   - Long lists with images and variable-height content.

10. **Grids, collections, cards, and carousels**

   - Fixed, flexible, and adaptive grids.
   - Lazy grids with varying content sizes.
   - Grid spacing, alignment, and spanning.
   - Photo grids and selection.
   - Card anatomy: image, title, metadata, and actions.
   - Horizontal card carousels and partial next-card previews.
   - Paging indicators.
   - Grid-to-detail transitions.
   - Reorderable collections.
   - Custom wrapping and masonry layouts.
   - Empty and partially filled grids.
   - Grid adaptation across device widths.

11. **Buttons, menus, and action controls**

   - Built-in button styles.
   - Button sizes, shapes, and label arrangements.
   - Full-width and content-width buttons.
   - Primary and secondary action hierarchy.
   - Destructive actions.
   - Pressed, disabled, loading, and success states.
   - Toggle buttons and selected states.
   - Repeating buttons.
   - Menu sections, separators, and submenus.
   - Menus with selection indicators.
   - Menus with a primary action.
   - Context menus and previews.
   - Context-menu actions for multiple selections.
   - Custom button styles and their accessibility behavior.
   - Hit targets and `contentShape`.

12. **Pickers and value controls**

   - Segmented, menu, wheel, inline, and navigation-style pickers where supported.
   - Picker labels and selected-value presentation.
   - Long picker labels.
   - Toggles and different label arrangements.
   - Continuous and stepped sliders.
   - Slider labels, endpoints, and feedback.
   - Steppers and numeric values.
   - Date-picker styles.
   - Time, date-range, and multiple-date selection.
   - Calendar localization and time-zone effects.
   - Color pickers.
   - Ratings, chips, and other custom selection controls.
   - Single-selection versus multiple-selection patterns.

13. **Text input, editing, and keyboards**

   - Text-field styles and labels.
   - Placeholder text versus persistent labels.
   - Secure fields and password visibility.
   - Multiline text fields.
   - Plain and rich text editors.
   - Text selection, editing menus, and selection handles.
   - Keyboard types and submit labels.
   - Focus management and next-field navigation.
   - Keyboard accessory actions.
   - Autofill and one-time-code entry.
   - Search fields within forms.
   - Input formatting for numbers, currency, dates, and phone numbers.
   - Inline validation and error messages.
   - Character counts and limits.
   - Clear buttons and input adornments.
   - Dictation, paste, and international text composition.
   - Hardware-keyboard behavior.
   - Keyboard avoidance inside lists, sheets, and custom layouts.

14. **Search experiences**

   - Search placement in navigation and tabs.
   - Search activation, focus, and cancellation.
   - Search suggestions.
   - Recent searches.
   - Search scopes.
   - Search tokens.
   - Filters and active-filter summaries.
   - Empty query, no results, loading, and error states.
   - Search-result highlighting.
   - Grouped and categorized results.
   - Searching within a selected collection.
   - Preserving search state during navigation.
   - Search combined with split views.
   - Voice or natural-language search as custom patterns.

15. **Typography and text presentation**

   - System text styles.
   - Font weights, widths, and designs.
   - Custom fonts with Dynamic Type.
   - Line spacing, tracking, and kerning.
   - Baseline alignment.
   - Wrapping, truncation, and line limits.
   - Minimum scaling and fixed-size behavior.
   - Monospaced digits and changing numeric values.
   - Attributed text and Markdown rendering.
   - Links embedded in text.
   - Text selection in read-only content.
   - Relative dates, durations, and live timers.
   - Expandable “read more” text.
   - Rich-text formatting controls.
   - Readable line lengths on wide displays.

16. **Symbols, images, shapes, and color**

   - SF Symbols rendering modes.
   - Symbol weights, scales, and text alignment.
   - Filled, outlined, and context-dependent symbol variants.
   - Variable symbols and symbol effects.
   - Symbol replacement transitions.
   - Custom symbols.
   - Semantic colors and hierarchical foreground styles.
   - Light, dark, and increased-contrast palettes.
   - Gradients and mesh gradients.
   - Image fit, fill, crop, and clipping.
   - Rounded rectangles, capsules, and concentric corners.
   - Borders, strokes, shadows, and elevation.
   - Masks, overlays, and blend modes.
   - Avatars, initials, and fallback imagery.
   - App-icon appearance variants.

17. **Layout fundamentals and adaptive composition**

   - Stack spacing and alignment.
   - Baseline alignment and custom alignment guides.
   - Flexible and fixed frames.
   - Layout priority and compression.
   - Padding, margins, and safe areas.
   - Overlay versus stack composition.
   - `ViewThatFits`.
   - `AnyLayout` and layout transitions.
   - Custom layouts.
   - Wrapping chip and tag layouts.
   - Aspect ratios and container-relative sizing.
   - Geometry-driven layouts.
   - Intrinsic-size content versus expanding content.
   - Readable-width constraints.
   - Layout changes at accessibility text sizes.
   - Visual examples of modifier-order effects.

18. **Animation and transitions**

   - Default, spring, and timing-curve animations.
   - Explicit and implicit animation.
   - Insertion and removal transitions.
   - Asymmetric transitions.
   - Matched geometry.
   - Navigation zoom transitions.
   - Numeric and text content transitions.
   - Symbol animations.
   - Keyframe and phase animation.
   - Animating between layouts.
   - Gesture-driven interactive transitions.
   - Interrupted and reversed animations.
   - Animation completion and chained actions.
   - Loading, success, and error motion.
   - Reduced-motion alternatives.

19. **Gestures, drag and drop, and feedback**

   - Tap, double-tap, and long-press interactions.
   - Drag gestures.
   - Magnification and rotation.
   - Simultaneous and competing gestures.
   - Gestures inside scroll views.
   - Swipe-to-reveal custom actions.
   - Scrubbing and direct manipulation.
   - Drag previews.
   - Drop targets and insertion indicators.
   - Reordering through drag and drop.
   - Dragging between app sections and other apps.
   - Multi-item dragging.
   - Selection, impact, success, warning, and error haptics.
   - Visual alternatives to haptic or audio feedback.
   - Touch cancellation and interrupted interactions.

20. **Accessibility**

   - Dynamic Type through the largest accessibility sizes.
   - Bold Text.
   - VoiceOver labels, values, hints, and reading order.
   - Grouping and separating accessibility elements.
   - Custom accessibility actions.
   - Adjustable custom controls.
   - Focus movement after presentation and dismissal.
   - Announcing loading, errors, and completion.
   - Reduce Motion.
   - Reduce Transparency.
   - Increase Contrast.
   - Differentiate Without Color.
   - Button Shapes and On/Off Labels.
   - Voice Control and discoverable action names.
   - Switch Control and keyboard navigation.
   - Accessible charts and images.
   - Touch-target size and spacing.
   - Captions, transcripts, and non-audio alternatives.

   These should also be variations on ordinary entries, so accessibility is visible throughout the catalog. [Apple’s accessibility guidance](https://developer.apple.com/design/human-interface-guidelines/accessibility?changes=latest_maj_6_3&language=objc).

21. **Localization and international layouts**

   - Right-to-left navigation and layout.
   - Directional icons and mirroring.
   - Long translated labels.
   - Mixed-direction text.
   - Pluralization and variable-length messages.
   - Localized dates, calendars, times, and numbers.
   - Currency and measurement formatting.
   - Text expansion in buttons, tabs, sheets, and alerts.
   - Different scripts and font fallback.
   - International names, addresses, and input methods.

22. **iPhone Duo and changing device configurations**

   - Outer-display and inner-display layouts.
   - Fully open and partially folded configurations.
   - Folding and unfolding while retaining navigation state.
   - Size classes versus actual available space.
   - Safe areas and reserved regions.
   - Placement of important content around the fold.
   - Horizontal-to-vertical navigation and toolbars.
   - Toolbar overflow on constrained edges.
   - Sheet placement on either side.
   - Popovers and menus near the fold.
   - Keyboard appearance in different configurations.
   - Primary content with secondary controls.
   - Split and overlay arrangements.
   - Arrangement proportions and size constraints.
   - Video with controls, document with inspector, and map with results.
   - Scroll-position and selection preservation during resizing.
   - Compatibility layouts from older SDK builds.
   - Equivalent layouts in Apple’s own apps.

   Apple documents both SDK-dependent layouts and adaptive arrangements. `ArrangementView` and related APIs currently marked beta should carry that status in the catalog. [Preparing for iPhone Duo](https://developer.apple.com/iphone-duo/prepare/), [adaptive arrangements](https://developer.apple.com/documentation/swiftui/view/arrangementviewstyle%28_%3A%29).

23. **iPad and wider-window adaptation**

   - Phone-to-tablet layout changes.
   - Resizable windows and narrow window widths.
   - Sidebar, content, detail, and inspector combinations.
   - Sheet sizing and popover adaptation.
   - Pointer hover and cursor interactions.
   - Keyboard shortcuts and discoverability.
   - Selection and editing with a hardware keyboard.
   - Drag and drop between windows.
   - Multiple windows showing the same content.
   - Apple Pencil input where relevant.
   - Dense information layouts with readable content widths.

24. **Loading, empty, error, and offline states**

   - Indeterminate and determinate progress.
   - Inline versus full-screen loading.
   - Skeletons, placeholders, and redacted content.
   - First-use empty states.
   - Empty collections and no search results.
   - `ContentUnavailableView`.
   - Recoverable errors and retry.
   - Partial failures within otherwise usable content.
   - Offline and stale-content indicators.
   - Background refresh indicators.
   - Optimistic updates and rollback.
   - Cancellation and interrupted tasks.
   - Success confirmation and undo.
   - Content appearing without disruptive layout jumps.

25. **Forms and complete task flows**

   - Settings forms.
   - Create and edit forms.
   - Required and optional fields.
   - Dependent and conditional fields.
   - Inline versus submit-time validation.
   - Save, cancel, and unsaved changes.
   - Multi-step flows and progress.
   - Onboarding and feature introduction.
   - Profile and account editing.
   - Filter and sort sheets.
   - Selection flows with confirmation.
   - Batch editing.
   - Destructive actions with recovery.
   - Import, processing, and completion.
   - Persistent bottom actions with scrolling content.

26. **Photos, video, audio, and drawing**

   - System photo selection.
   - Single and multiple media selection.
   - Limited-library and unavailable-media states.
   - Photo grids and full-screen viewers.
   - Pinch to zoom and double-tap zoom.
   - Thumbnail-to-detail transitions.
   - Image loading, failure, and aspect-ratio preservation.
   - Video playback and native controls.
   - Full-screen playback and Picture in Picture.
   - Mini players and expanded players.
   - Playback queues and transcripts.
   - Audio recording controls and waveform displays.
   - Camera-preview layouts and capture feedback.
   - Drawing and annotation tools.
   - Cropping, markup, and other custom editing flows.

27. **Maps and location interfaces**

   - Map styles and camera positions.
   - Annotations, markers, and selected states.
   - Annotation clustering.
   - Routes and overlays.
   - Map controls and user-location actions.
   - Search results connected to map selection.
   - Maps with movable sheets.
   - Map gestures competing with surrounding interfaces.
   - Location permission and unavailable-location states.
   - Place-detail cards and route summaries.

28. **Charts and data presentation**

   - Line, bar, area, point, and sector charts.
   - Axes, legends, labels, and annotations.
   - Selection and scrubbing.
   - Scrollable charts and time windows.
   - Multiple series and comparison periods.
   - Empty, sparse, and missing data.
   - Very small, very large, and negative values.
   - Chart animation and live updates.
   - Accessible chart descriptions.
   - Gauges, progress rings, and metric cards.
   - Tables and sortable data.
   - Heatmaps, timelines, and custom visualizations.
   - 3D charts where they communicate something useful.

29. **System-provided interfaces and integrations**

   - Share sheets and `ShareLink`.
   - Sharing files, images, text, and links.
   - File importers and exporters.
   - Document browsers and document-based app entry screens.
   - Quick Look previews.
   - Native web views and browser presentation.
   - Mail and message composition.
   - Contact selection.
   - Calendar event editing.
   - Document and text scanning.
   - Print interfaces.
   - Translation presentations.
   - Writing Tools interaction with editable text.
   - TipKit tips and contextual education.
   - System interfaces that require UIKit wrappers.

30. **Authentication, permissions, and privacy interfaces**

   - Sign in with Apple.
   - Passkey and password flows.
   - Biometric authentication.
   - Authentication cancellation and failure.
   - Session-expired and reauthentication states.
   - Permission requests in context.
   - Denied, restricted, and limited access.
   - Explaining how to change access in Settings.
   - Camera, microphone, photos, location, and notification access.
   - Sensitive-content obscuring and reveal controls.
   - Account deletion and confirmation.
   - Privacy settings and data-export flows.

31. **Purchases, subscriptions, and entitlement states**

   - Native StoreKit product and subscription views.
   - Custom paywall composition.
   - Plan comparison and selection.
   - Localized prices and billing periods.
   - Trial and introductory-offer presentation.
   - Purchase in progress, cancelled, pending, failed, and completed.
   - Restore purchases.
   - Existing-subscriber states.
   - Subscription management.
   - Expired access and feature gating.
   - Offer redemption.
   - Clear disclosure placement and accessible purchase controls.

32. **Interfaces outside the main app**

   - Home Screen widgets.
   - Lock Screen widgets.
   - Interactive widgets.
   - Widget configuration.
   - Widget families, margins, and rendering modes.
   - Live Activities on the Lock Screen.
   - Dynamic Island compact, minimal, and expanded presentations.
   - Stale and ended Live Activity states.
   - Control Center controls.
   - Notifications and notification actions.
   - Rich notification content.
   - Spotlight result presentation.
   - Siri and Shortcuts action presentation.
   - App Shortcuts and discoverability.
   - App icons in different system appearances.
   - Launch screens and the transition into usable content.

33. **Apple-app case studies**

   These would be investigations of specific screens and interactions, with captures from relevant versions and devices:

   - **Settings:** grouped forms, disclosure rows, search, and explanatory footers.
   - **Notes:** editing, formatting, attachments, navigation, and wide layouts.
   - **Reminders:** inline creation, completion, grouping, and detail editing.
   - **Mail:** message lists, swipe actions, compose, and split layouts.
   - **Messages:** conversation scrolling, composer growth, attachments, and contextual actions.
   - **Photos:** grids, selection, image transitions, and editing controls.
   - **Music:** mini player, expanded player, queue, lyrics, and tab accessories.
   - **Podcasts:** playback, transcripts, queues, and adaptive arrangements.
   - **Maps:** search, draggable sheets, place details, and floating controls.
   - **Safari:** address entry, browser controls, tab management, and page actions.
   - **Calendar:** date navigation, event creation, and different information densities.
   - **Files:** document browsing, grid/list switching, selection, and context menus.
   - **Books:** reading controls, typography settings, selection, and progress.
   - **App Store:** editorial cards, product pages, search, and download states.
   - **Wallet:** stacked cards, detail presentation, and action hierarchy.
   - **Weather:** layered backgrounds, dense information, and charts.
   - **Health and Fitness:** summaries, progress, charts, and drill-down.
   - **Camera:** viewfinder controls and device adaptation.
   - **Clock:** pickers, timers, alarms, and active states.
   - **Contacts and Phone:** identity, grouped actions, lists, and editing.
   - **Journal:** entry composition, media, prompts, and browsing.
   - **Passwords:** authentication, grouped credentials, and detail layouts.
   - **Stocks:** watchlists, chart inspection, and related content.
   - **Voice Memos:** recording, playback, waveform interaction, and editing.
   - **Calculator:** keypad layout, modes, and history.
   - **Home:** control tiles, room navigation, and device states.

   Each case study should distinguish what we observed from what we can reproduce with public APIs.

34. **Community discoveries and custom interface patterns**

   - Small discoveries from Sarun and other developers.
   - Lesser-known modifiers with visible effects.
   - Before-and-after examples showing a single modifier.
   - Native-looking custom bottom sheets.
   - Expandable cards and disclosure panels.
   - Floating action controls and action trays.
   - Toasts, banners, and undo notices.
   - Chat interfaces and growing composers.
   - Command menus and action search.
   - Timelines, schedules, and calendar compositions.
   - Custom segmented controls and selection indicators.
   - Swipeable cards.
   - Image comparison sliders.
   - Interactive onboarding and walkthroughs.
   - Shader-based effects and custom rendering.
   - Comparisons between a custom pattern and the closest system component.

   Each discovery should retain its original source and attribution. [Sarun’s blog](https://sarunw.com/) is a useful ongoing source.

35. **Version differences, interoperability, and regressions**

   - The same source code running on different iOS versions.
   - The same runtime with builds from different SDKs.
   - Default control appearances across iOS 18, 26, and 27.
   - Sheet geometry, backgrounds, and presentation animations.
   - Navigation, tab-bar, and toolbar changes.
   - Automatic scroll-edge behavior.
   - Text-selection and editing behavior.
   - Menu and popover sizing and adaptation.
   - Environment values propagating into presentations.
   - SwiftUI and UIKit versions of equivalent interfaces.
   - SwiftUI embedded in UIKit, and UIKit embedded in SwiftUI.
   - Safe-area and keyboard behavior at framework boundaries.
   - New APIs with older-version fallbacks.
   - Minimal reproductions of confirmed visual bugs.
   - Workarounds alongside their original reproduction.
   - Fixed regressions, retaining the affected-version captures.
   - Beta-to-release changes with exact build identifiers.

   Apple’s iOS 27 release notes already provide concrete candidates involving selectable text and environment values in sheets and popovers. Its WWDC26 overview also identifies toolbar, reordering, and presentation additions worth cataloging. [iOS 27 release notes](https://developer.apple.com/documentation/ios-ipados-release-notes/ios-ipados-27-release-notes?changes=latest_maj_2_9_8__1_5_10__4), [What’s new in SwiftUI](https://developer.apple.com/videos/play/wwdc2026/269/).

**Across those categories, I’d use a shared comparison matrix.** These would be filters and capture variations on entries:

| Dimension | Variations to capture where relevant |
|---|---|
| OS | iOS 18, 26, 27; exact minor version and build |
| Build environment | Xcode, SDK, deployment target, source commit |
| Device | Small and large iPhones, iPhone Duo, iPad |
| Configuration | Portrait, landscape, window width, folded/open states |
| Appearance | Light, dark, increased contrast, reduced transparency |
| Text | Default, large, and accessibility sizes; Bold Text |
| Language | Short and long translations, right-to-left layouts |
| Input | Touch, hardware keyboard, pointer, Pencil |
| Accessibility | VoiceOver, Reduce Motion, alternative interaction |
| Content | Empty, typical, unusually long, unusually large |
| State | Idle, selected, editing, loading, error, disabled |
| Interaction | Before, during, after, cancelled, interrupted |

**For the first collection, I’d prioritize:** sheets; scroll-edge effects; Liquid Glass; toolbar grouping; tab minimization and accessories; navigation titles; search; list styling; keyboard interactions; Dynamic Type; iPhone Duo layouts; and a handful of Apple-app case studies. Those establish the visual, behavioral, and version-comparison strengths of iOS Design Atlas immediately.
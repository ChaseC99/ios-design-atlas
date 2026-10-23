---
id: "interactive-widget"
title: "Interactive widgets"
summary: "An App Intent button can update a widget without opening the containing app."
category: "System surfaces"
family: "Widgets and activities"
order: 3202
kind: "native"
demoMinIOS: "18.0"
swiftFile: "InteractiveWidgetDemo.swift"
view: "InteractiveWidgetDemo"
apis: ["AppIntent", "Button(intent:)", "WidgetCenter"]
tags: ["widgetkit", "system", "outside-app"]
captureNavigation: true
captureManual: true
captureManualReason: "Record the installed widget before and after a real App Intent action. The sample intent and counter live in the extension only; sharing data with the containing app would require an App Group and shared storage. This is a UI fixture, not hydration advice or health tracking."
---

# Interactive widgets

An App Intent button can update a widget without opening the containing app. WidgetKit reloads the tapped widget after the intent finishes; the full example also offers a reset action once its local counter reaches eight.

## SwiftUI

```swift
import SwiftUI
import WidgetKit
import AppIntents

// Compile this intent in the widget extension target.
struct AddGlass: AppIntent {
    static let title: LocalizedStringResource = "Add a glass"
    static let isDiscoverable = false
    @MainActor func perform() async throws -> some IntentResult {
        let store = UserDefaults.standard
        let current = min(8, max(0, store.object(forKey: "glasses") as? Int ?? 3))
        store.set(min(current + 1, 8), forKey: "glasses")
        WidgetCenter.shared.reloadTimelines(ofKind: "Water") // Refresh other instances of this kind too.
        return .result()
    }
}
struct WidgetAction: View {
    var body: some View {
        Button(intent: AddGlass()) { Label("Add a glass", systemImage: "plus") }
    }
}
```

## Captures

<!-- captures:start -->
Native system-surface captures are pending. The in-app view is a content preview.
<!-- captures:end -->

## Full example

[Open the complete runnable example](InteractiveWidgetDemo.swift). The same source is compiled by the AtlasWidgets extension. Its `ATLAS_WIDGET_EXTENSION` compilation condition includes the widget and intents there, while the app compiles only the independent content preview. Add this condition to a widget-extension target when reusing the full file; the short recipe belongs in that target.

Record the installed widget before and after a real App Intent action. The sample intent and counter live in the extension only; sharing data with the containing app would require an App Group and shared storage. This is a UI fixture, not hydration advice or health tracking.

## References

[Apple: WidgetKit](https://developer.apple.com/documentation/widgetkit). [Apple: widget interactivity](https://developer.apple.com/documentation/widgetkit/adding-interactivity-to-widgets-and-live-activities).

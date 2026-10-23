---
id: "tipkit-education"
title: "Contextual education with TipKit"
summary: "Place a native tip beside its related action."
category: "Integrations"
family: "Education"
order: 2908
kind: "native"
demoMinIOS: "18.0"
swiftFile: "TipKitEducationDemo.swift"
view: "TipKitEducationDemo"
apis: ["Tip", "TipView", "Tips.configure", "invalidate"]
tags: ["tipkit", "contextual-help", "education", "eligibility"]
captureNavigation: true
captureStyle: "screen"
---

# Contextual education with TipKit

TipKit presents contextual guidance using native tip layouts and persisted eligibility. An inline tip can point toward an available action and invalidate after that action succeeds. This example configures TipKit when opened, respects its saved dismissal state, and changes only a local sample collection.

## SwiftUI

```swift
import SwiftUI
import TipKit

private struct SavePlaceTip: Tip {
    var title: Text { Text("Keep a place for later") }
    var message: Text? { Text("Save places to build a collection for your next trip.") }
    var image: Image? { Image(systemName: "bookmark") }
}
struct TipRecipe: View {
    private let tip = SavePlaceTip()
    @State private var saved = false
    var body: some View {
        VStack(spacing: 24) {
            TipView(tip)
            Button(saved ? "Saved" : "Save place") { saved = true; tip.invalidate(reason: .actionPerformed) }
                .disabled(saved)
        }.padding().task { try? Tips.configure() }
    }
}
```

## Captures

<!-- captures:start -->
Captures have not been recorded yet.
<!-- captures:end -->

## Full example

[Open the complete runnable example](TipKitEducationDemo.swift).

## Reference

[Apple: TipKit](https://developer.apple.com/documentation/tipkit/highlightingappfeatureswithtipkit).

---
id: "glass-variants"
title: "Regular, clear, and tinted glass"
summary: "Different glass treatments on the same background."
category: "Materials"
family: "Liquid Glass"
order: 803
kind: "native"
demoMinIOS: "26.0"
swiftFile: "GlassVariantsDemo.swift"
view: "GlassVariantsDemo"
captureNavigation: true
captureStyle: "screen"
apis: ["glassEffect", "Glass"]
tags: ["regular", "clear", "tint"]
---

# Regular, clear, and tinted glass

Liquid Glass provides regular and clear treatments for custom controls, with optional tinting to give an action emphasis.

## SwiftUI

```swift
import SwiftUI

@available(iOS 26.0, *)
struct TintedGlassControl: View {
    @State private var saved = false
    var body: some View {
        Button { saved.toggle() } label: {
            Label(saved ? "Saved" : "Save", systemImage: "bookmark")
                .padding(.horizontal, 24).padding(.vertical, 16)
        }
        .buttonStyle(.plain)
        .glassEffect(.regular.tint(.teal).interactive(), in: Capsule())
    }
}
```

## Captures

<!-- captures:start -->
<!-- captures:end -->

## Full example

[Open the complete runnable example](GlassVariantsDemo.swift).

## Reference

[Apple: glassEffect](https://developer.apple.com/documentation/swiftui/glass).

---
id: "layout-switching"
title: "Switching layouts with AnyLayout"
summary: "Move the same views into a new arrangement."
category: "Layout"
family: "Adaptation"
order: 1706
kind: "native"
demoMinIOS: "18.0"
swiftFile: "LayoutSwitchingDemo.swift"
view: "LayoutSwitchingDemo"
apis: ["AnyLayout", "HStackLayout", "VStackLayout", "animation"]
tags: ["identity", "layout-transition", "state", "reduce-motion"]
captureNavigation: true
captureStyle: "screen"
---

# Switching layouts with AnyLayout

AnyLayout changes the layout algorithm while retaining the identity of its child views. This preserves local state as the arrangement changes; the app demonstrates the transition, while a capture shows one resting arrangement.

## SwiftUI

```swift
import SwiftUI

struct AnyLayoutRecipe: View {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var vertical = false
    var body: some View {
        let layout = vertical ? AnyLayout(VStackLayout(spacing: 16)) : AnyLayout(HStackLayout(spacing: 16))
        VStack(spacing: 24) {
            layout {
                Image(systemName: "leaf.fill")
                Text("Weekend references")
            }
            Toggle("Vertical layout", isOn: $vertical)
        }
        .animation(reduceMotion ? nil : .smooth, value: vertical)
    }
}
```

## Captures

<!-- captures:start -->
Captures have not been recorded yet.
<!-- captures:end -->

## Full example

[Open the complete runnable example](LayoutSwitchingDemo.swift).

## Reference

[Apple: layout](https://developer.apple.com/design/human-interface-guidelines/layout).

---
id: "tap-and-press"
title: "Taps and long presses"
summary: "Resolve taps, double taps, and a held touch."
category: "Gestures"
family: "Gesture composition"
order: 1901
kind: "native"
demoMinIOS: "18.0"
swiftFile: "TapAndPressDemo.swift"
view: "TapAndPressDemo"
apis: ["TapGesture", "LongPressGesture", "exclusively", "GestureState"]
tags: ["tap", "double-tap", "long-press", "cancellation", "accessibility"]
captureNavigation: true
captureStyle: "screen"
---

# Taps and long presses

Exclusive gestures give a long press, double tap, and single tap distinct actions on the same view. Gesture state resets when a touch ends or is cancelled, while named accessibility actions provide the same outcomes without timing a touch.

## SwiftUI

```swift
import SwiftUI

struct TapAndPressRecipe: View {
    @State private var result = "Ready"
    @GestureState private var pressing = false
    var body: some View {
        Text(result).padding(40).background(pressing ? Color.teal.opacity(0.2) : .gray.opacity(0.1))
            .gesture(LongPressGesture(minimumDuration: 0.6)
                .updating($pressing) { value, state, _ in state = value }
                .exclusively(before: TapGesture(count: 2).exclusively(before: TapGesture()))
                .onEnded { value in
                    switch value {
                    case .first: result = "Long press"
                    case .second(.first): result = "Double tap"
                    case .second(.second): result = "Single tap"
                    }
                })
            .accessibilityAction(named: "Single tap") { result = "Single tap" }
            .accessibilityAction(named: "Double tap") { result = "Double tap" }
            .accessibilityAction(named: "Long press") { result = "Long press" }
    }
}
```

## Captures

<!-- captures:start -->
Captures have not been recorded yet.
<!-- captures:end -->

## Full example

[Open the complete runnable example](TapAndPressDemo.swift).

## Reference

[Apple: gestures](https://developer.apple.com/design/human-interface-guidelines/gestures).

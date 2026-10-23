---
id: "simultaneous-transforms"
title: "Magnify and rotate"
summary: "Combine two continuous gestures on one canvas."
category: "Gestures"
family: "Direct manipulation"
order: 1902
kind: "native"
demoMinIOS: "18.0"
swiftFile: "SimultaneousTransformsDemo.swift"
view: "SimultaneousTransformsDemo"
apis: ["MagnifyGesture", "RotateGesture", "simultaneously", "GestureState"]
tags: ["magnification", "rotation", "simultaneous", "cancellation", "accessibility"]
captureNavigation: true
captureStyle: "screen"
---

# Magnify and rotate

Simultaneous magnification and rotation let two fingers transform the same content. Transient gesture values disappear on cancellation; committed values remain after a completed gesture, with buttons offering precise and accessible adjustments.

## SwiftUI

```swift
import SwiftUI

struct TransformRecipe: View {
    @State private var scale = 1.0
    @State private var angle = Angle.zero
    @GestureState private var liveScale = 1.0
    @GestureState private var liveAngle = Angle.zero
    var body: some View {
        Image(systemName: "leaf.fill").font(.system(size: 100)).foregroundStyle(.teal)
            .scaleEffect(min(2, max(0.5, scale * liveScale)))
            .rotationEffect(angle + liveAngle)
            .gesture(MagnifyGesture()
                .updating($liveScale) { value, state, _ in state = value.magnification }
                .onEnded { scale = min(2, max(0.5, scale * $0.magnification)) }
                .simultaneously(with: RotateGesture()
                    .updating($liveAngle) { value, state, _ in state = value.rotation }
                    .onEnded { angle += $0.rotation }))
            .accessibilityAdjustableAction { direction in
                scale = min(2, max(0.5, scale + (direction == .increment ? 0.1 : -0.1)))
            }
            .accessibilityAction(named: "Rotate clockwise") { angle += .degrees(45) }
    }
}
```

## Captures

<!-- captures:start -->
Captures have not been recorded yet.
<!-- captures:end -->

## Full example

[Open the complete runnable example](SimultaneousTransformsDemo.swift).

## Reference

[Apple: gestures](https://developer.apple.com/design/human-interface-guidelines/gestures).

---
id: "glass-shapes"
title: "Glass shapes and interaction"
summary: "Define a glass surface with its shape."
category: "Materials"
family: "Liquid Glass"
order: 804
kind: "native"
demoMinIOS: "26.0"
swiftFile: "GlassShapesDemo.swift"
view: "GlassShapesDemo"
captureNavigation: true
captureStyle: "screen"
apis: ["glassEffect", "Glass.interactive"]
tags: ["shape", "capsule", "circle", "rounded rectangle"]
---

# Glass shapes and interaction

The shape passed to a glass effect defines its surface; interactive glass responds to touches on a custom control.

## SwiftUI

```swift
import SwiftUI

@available(iOS 26.0, *)
struct CircularGlassButton: View {
    @State private var playing = false
    var body: some View {
        Button { playing.toggle() } label: {
            Image(systemName: playing ? "pause.fill" : "play.fill")
                .font(.title2).frame(width: 64, height: 64)
        }
        .buttonStyle(.plain)
        .glassEffect(.regular.interactive(), in: Circle())
        .accessibilityLabel(playing ? "Pause" : "Play")
    }
}
```

## Captures

<!-- captures:start -->
<!-- captures:end -->

## Full example

[Open the complete runnable example](GlassShapesDemo.swift).

## Reference

[Apple: glassEffect](https://developer.apple.com/documentation/swiftui/view/glasseffect(_:in:)).

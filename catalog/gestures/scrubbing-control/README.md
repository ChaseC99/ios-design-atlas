---
id: "scrubbing-control"
title: "Scrubbing and direct manipulation"
summary: "Map a drag position directly to a value."
category: "Gestures"
family: "Direct manipulation"
order: 1904
kind: "custom"
demoMinIOS: "18.0"
swiftFile: "ScrubbingControlDemo.swift"
view: "ScrubbingControlDemo"
apis: ["DragGesture", "GeometryReader", "accessibilityAdjustableAction"]
tags: ["scrubbing", "drag", "adjustable", "cancellation"]
captureNavigation: true
captureStyle: "screen"
---

# Scrubbing and direct manipulation

A scrubber converts the finger’s horizontal location into a bounded value and commits it when the drag ends. A cancelled touch restores the committed position; adjustable accessibility actions and step buttons offer equivalent control. This example changes a local preview position without playing audio.

## SwiftUI

```swift
import SwiftUI

struct ScrubbingRecipe: View {
    @State private var position = 0.4
    @GestureState private var preview: Double?
    var body: some View {
        GeometryReader { geometry in
            let value = preview ?? position
            Capsule().fill(.teal.opacity(0.15)).frame(height: 12)
                .overlay(alignment: .leading) {
                    Capsule().fill(.teal).frame(width: geometry.size.width * value, height: 12)
                }
                .frame(height: 44).contentShape(.rect)
                .gesture(DragGesture(minimumDistance: 0)
                    .updating($preview) { value, state, _ in
                        state = min(1, max(0, value.location.x / max(1, geometry.size.width)))
                    }
                    .onEnded { position = min(1, max(0, $0.location.x / max(1, geometry.size.width))) })
                .accessibilityElement()
                .accessibilityLabel("Preview position")
                .accessibilityValue(value.formatted(.percent))
                .accessibilityAdjustableAction { direction in
                    position = min(1, max(0, position + (direction == .increment ? 0.05 : -0.05)))
                }
        }.frame(height: 44).padding()
    }
}
```

## Captures

<!-- captures:start -->
Captures have not been recorded yet.
<!-- captures:end -->

## Full example

[Open the complete runnable example](ScrubbingControlDemo.swift).

## Reference

[Apple: gestures](https://developer.apple.com/design/human-interface-guidelines/gestures).

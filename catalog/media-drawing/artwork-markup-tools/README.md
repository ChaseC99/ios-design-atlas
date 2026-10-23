---
id: "artwork-markup-tools"
title: "Draw over an artwork"
summary: "Annotate an original illustration with undo and color controls."
category: "Media & drawing"
family: "Editing"
order: 2608
kind: "custom"
demoMinIOS: "18.0"
swiftFile: "ArtworkMarkupToolsDemo.swift"
view: "ArtworkMarkupToolsDemo"
captureNavigation: true
ownsNavigation: false
captureStyle: "screen"
apis: ["Canvas", "DragGesture", "Path"]
tags: ["markup", "annotation", "drawing"]
---

# Draw over an artwork

A Canvas renders normalized annotation strokes over original artwork; undo removes the latest stroke and resizing keeps its relative position.

## SwiftUI

```swift
import SwiftUI

struct DrawAStroke: View {
    @State private var points: [CGPoint] = []
    var body: some View {
        Canvas { context, _ in
            var path = Path()
            if let first = points.first {
                path.move(to: first)
                for point in points.dropFirst() { path.addLine(to: point) }
            }
            context.stroke(path, with: .color(.teal), style: StrokeStyle(lineWidth: 4, lineCap: .round))
        }
        .background(.teal.opacity(0.08))
        .gesture(DragGesture(minimumDistance: 0).onChanged { points.append($0.location) })
    }
}
```

## Captures

<!-- captures:start -->
<!-- captures:end -->

## Full example

[Open the complete runnable example](ArtworkMarkupToolsDemo.swift).

## Reference

[Apple: Canvas](https://developer.apple.com/documentation/swiftui/canvas).

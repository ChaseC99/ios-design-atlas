---
id: "pencil-drawing-canvas"
title: "A native drawing canvas"
summary: "Draw with a finger or Apple Pencil using PencilKit."
category: "Wide layouts"
family: "Input adaptation"
order: 2306
kind: "native"
demoMinIOS: "18.0"
swiftFile: "PencilDrawingCanvasDemo.swift"
view: "PencilDrawingCanvasDemo"
captureNavigation: true
ownsNavigation: false
captureStyle: "screen"
apis: ["PKCanvasView", "PKDrawing", "UIViewRepresentable"]
tags: ["Apple Pencil", "drawing", "iPad"]
---

# A native drawing canvas

PencilKit provides editable native strokes; this canvas accepts finger input, while Apple Pencil behavior requires a compatible iPad and Pencil.

## SwiftUI

```swift
import SwiftUI
import PencilKit

struct DrawingCanvas: UIViewRepresentable {
    @Binding var drawing: PKDrawing
    func makeCoordinator() -> Coordinator { Coordinator(self) }
    func makeUIView(context: Context) -> PKCanvasView {
        let canvas = PKCanvasView()
        canvas.drawingPolicy = .anyInput
        canvas.tool = PKInkingTool(.pen, color: .systemTeal, width: 5)
        canvas.delegate = context.coordinator
        return canvas
    }
    func updateUIView(_ canvas: PKCanvasView, context: Context) {
        context.coordinator.parent = self
        if canvas.drawing != drawing { canvas.drawing = drawing }
    }
    final class Coordinator: NSObject, PKCanvasViewDelegate {
        var parent: DrawingCanvas
        init(_ parent: DrawingCanvas) { self.parent = parent }
        func canvasViewDrawingDidChange(_ canvas: PKCanvasView) { parent.drawing = canvas.drawing }
    }
}
```

## Captures

<!-- captures:start -->
<!-- captures:end -->

## Full example

[Open the complete runnable example](PencilDrawingCanvasDemo.swift).

## Reference

[Apple: PKCanvasView](https://developer.apple.com/documentation/pencilkit/pkcanvasview).

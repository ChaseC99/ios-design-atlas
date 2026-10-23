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
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![A native drawing canvas on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792766316.699.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![A native drawing canvas on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792766125.946.png)

### iPhone Duo · iOS 27.1

default. light appearance; Large text; en_US.

![A native drawing canvas on iPhone Duo, iOS 27.1](captures/ios-27-1-atlas-iphone-duo-default-1792767876.276.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](PencilDrawingCanvasDemo.swift).

## Reference

[Apple: PKCanvasView](https://developer.apple.com/documentation/pencilkit/pkcanvasview).

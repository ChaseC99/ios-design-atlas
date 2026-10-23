---
id: "drag-previews-and-drops"
title: "Drag previews and drop targets"
summary: "Move transferable content between sections."
category: "Gestures"
family: "Drag and drop"
order: 1905
kind: "native"
demoMinIOS: "18.0"
swiftFile: "DragPreviewsAndDropsDemo.swift"
view: "DragPreviewsAndDropsDemo"
apis: ["draggable", "dropDestination", "Transferable"]
tags: ["drag-preview", "drop-target", "cross-app", "cancellation", "accessibility"]
captureNavigation: true
captureStyle: "screen"
---

# Drag previews and drop targets

Transferable strings provide a native drag preview and can cross app boundaries. A drop destination highlights during targeting and updates its collection only after accepting a drop, so cancelling leaves the source untouched; an Add button provides the same local action.

## SwiftUI

```swift
import SwiftUI

struct DragDropRecipe: View {
    @State private var saved: [String] = []
    @State private var targeted = false
    var body: some View {
        VStack(spacing: 24) {
            Text("Harbor light").padding().background(.teal.opacity(0.1), in: .capsule)
                .draggable("Harbor light") { Label("Harbor light", systemImage: "photo").padding() }
            VStack { Text("Collection").font(.headline); ForEach(saved, id: \.self) { Text($0) } }
                .frame(maxWidth: .infinity, minHeight: 160)
                .background(targeted ? Color.teal.opacity(0.2) : .gray.opacity(0.08), in: .rect(cornerRadius: 20))
                .dropDestination(for: String.self) { values, _ in
                    let accepted = Array(Set(values)).filter { $0 == "Harbor light" && !saved.contains($0) }
                    saved.append(contentsOf: accepted)
                    return !accepted.isEmpty
                } isTargeted: { targeted = $0 }
            Button("Add Harbor light") { if saved.isEmpty { saved.append("Harbor light") } }
        }.padding()
    }
}
```

## Captures

<!-- captures:start -->
Captures have not been recorded yet.
<!-- captures:end -->

## Full example

[Open the complete runnable example](DragPreviewsAndDropsDemo.swift).

## Reference

[Apple: gestures](https://developer.apple.com/design/human-interface-guidelines/gestures).

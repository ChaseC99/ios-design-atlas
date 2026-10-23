---
id: "drag-between-collections"
title: "Drag between collections"
summary: "Move an idea from one board to another."
category: "Wide layouts"
family: "Input adaptation"
order: 2304
kind: "native"
demoMinIOS: "18.0"
swiftFile: "DragBetweenCollectionsDemo.swift"
view: "DragBetweenCollectionsDemo"
captureNavigation: true
ownsNavigation: false
captureStyle: "screen"
apis: ["draggable", "dropDestination", "AnyLayout"]
tags: ["drag and drop", "iPad", "selection"]
---

# Drag between collections

Draggable values and drop destinations move items between two collections; the same interaction works in stacked or side-by-side layouts.

## SwiftUI

```swift
import SwiftUI

struct MoveAnIdea: View {
    @State private var source = ["Reading nook", "Window garden"]
    @State private var destination: [String] = []
    var body: some View {
        HStack {
            VStack { ForEach(source, id: \.self) { Text($0).padding().draggable($0) } }
            VStack {
                Text("This week").font(.headline)
                ForEach(destination, id: \.self) { Text($0) }
            }
            .frame(minWidth: 120, minHeight: 160)
            .background(.teal.opacity(0.12))
            .dropDestination(for: String.self) { values, _ in
                let moved = values.filter { source.contains($0) }
                source.removeAll { moved.contains($0) }
                destination.append(contentsOf: moved)
                return !moved.isEmpty
            }
        }
    }
}
```

## Captures

<!-- captures:start -->
<!-- captures:end -->

## Full example

[Open the complete runnable example](DragBetweenCollectionsDemo.swift).

## Reference

[Apple: draggable](https://developer.apple.com/documentation/swiftui/view/dropdestination(for:action:istargeted:)).

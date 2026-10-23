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
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Drag between collections on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792765592.067.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Drag between collections on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792765513.815.png)

### iPhone 18 Pro · iOS 27.0

default. light appearance; Large text; en_US.

![Drag between collections on iPhone 18 Pro, iOS 27.0](captures/ios-27-0-iphone-18-pro-default-1792767751.576.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](DragBetweenCollectionsDemo.swift).

## Reference

[Apple: draggable](https://developer.apple.com/documentation/swiftui/view/dropdestination(for:action:istargeted:)).

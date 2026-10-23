---
id: "multi-item-dragging"
title: "Multi-item dragging"
summary: "Drag the selected items as one native session."
category: "Gestures"
family: "Drag and drop"
order: 1907
kind: "native"
demoMinIOS: "27.0"
swiftFile: "MultiItemDraggingDemo.swift"
view: "MultiItemDraggingDemo"
apis: ["dragContainer", "dragContainerSelection", "draggable(containerItemID:)", "onDragSessionUpdated"]
tags: ["multi-item", "selection", "drag-session", "cross-app", "ios-27"]
captureNavigation: true
captureStyle: "screen"
---

# Multi-item dragging

A drag container resolves selected item identifiers into transferable content so one native drag can carry several items. Session updates expose the interaction lifecycle without removing sources; the destination accepts copies, and Add selected offers a non-drag alternative. This SwiftUI container API requires iOS 27.

## SwiftUI

```swift
import SwiftUI

@available(iOS 27.0, *)
struct MultiDragRecipe: View {
    @State private var selection = ["Harbor", "Forest"]
    @State private var received: [String] = []
    var body: some View {
        VStack(spacing: 24) {
            VStack {
                ForEach(["Harbor", "Forest", "Mountain"], id: \.self) { item in
                    Text(item).padding().draggable(containerItemID: item)
                }
            }
            .dragContainer(for: String.self, itemID: \.self) { (ids: [String]) in ids }
            .dragContainerSelection(selection)
            Text(received.isEmpty ? "Drop selected places" : received.joined(separator: ", "))
                .padding(30).frame(maxWidth: .infinity).background(.teal.opacity(0.1))
                .dropDestination(for: String.self) { values, _ in received = values; return !values.isEmpty }
            Button("Add selected") { received = selection }
        }.padding()
    }
}
```

## Captures

<!-- captures:start -->
Captures have not been recorded yet.
<!-- captures:end -->

## Full example

[Open the complete runnable example](MultiItemDraggingDemo.swift).

## Reference

[Apple: gestures](https://developer.apple.com/design/human-interface-guidelines/gestures).

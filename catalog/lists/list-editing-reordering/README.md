---
id: "list-editing-reordering"
title: "Editing and reordering"
summary: "Edit mode exposes native deletion and drag handles for an ordered list."
category: "Lists"
family: "Actions"
order: 905
kind: "native"
demoMinIOS: "18.0"
swiftFile: "ListEditingReorderingDemo.swift"
view: "ListEditingReorderingDemo"
captureNavigation: true
ownsNavigation: false
apis: ["EditButton", "onDelete", "onMove"]
tags: ["reorder", "delete", "edit mode"]
---

# Editing and reordering

Edit mode exposes native deletion and drag handles for an ordered list.

## SwiftUI

```swift
import SwiftUI

struct ReorderableList: View {
    @State private var ideas = ["Find a café", "Take a walk", "Read a chapter"]

    var body: some View {
        NavigationStack {
            List {
                ForEach(ideas, id: \.self) { Text($0) }
                    .onDelete { ideas.remove(atOffsets: $0) }
                    .onMove { ideas.move(fromOffsets: $0, toOffset: $1) }
            }
            .toolbar { EditButton() }
        }
    }
}
```

## Captures

<!-- captures:start -->
<!-- captures:end -->

## Full example

[Open the complete runnable example](ListEditingReorderingDemo.swift).

## Reference

[Apple: EditButton](https://developer.apple.com/documentation/swiftui/list).

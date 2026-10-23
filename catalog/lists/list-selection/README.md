---
id: "list-selection"
title: "List selection"
summary: "Native list selection supports one item or a set of items for batch actions."
category: "Lists"
family: "Selection"
order: 903
kind: "native"
demoMinIOS: "18.0"
swiftFile: "ListSelectionDemo.swift"
view: "ListSelectionDemo"
captureNavigation: true
ownsNavigation: false
apis: ["List(selection:)", "EditMode", "toolbar"]
tags: ["single selection", "multiple selection", "batch actions"]
---

# List selection

Native list selection supports one item or a set of items for batch actions.

## SwiftUI

```swift
import SwiftUI

struct SelectableNotes: View {
    @State private var selected: Set<String> = []
    private let notes = ["Quiet mornings", "Open water", "The long way home"]

    var body: some View {
        List(notes, id: \.self, selection: $selected) { note in
            Text(note).tag(note)
        }
        .environment(\.editMode, .constant(.active))
        .safeAreaInset(edge: .bottom) {
            Text("\(selected.count) selected").padding()
        }
    }
}
```

## Captures

<!-- captures:start -->
<!-- captures:end -->

## Full example

[Open the complete runnable example](ListSelectionDemo.swift).

## Reference

[Apple: List(selection:)](https://developer.apple.com/documentation/swiftui/list).

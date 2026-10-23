---
id: "batch-editing-recovery"
title: "Batch actions and recovery"
summary: "A selection flow groups related actions, confirms destructive changes, and offers a direct undo."
category: "Forms"
family: "Flows"
order: 2507
kind: "native"
demoMinIOS: "18.0"
swiftFile: "BatchEditingRecoveryDemo.swift"
view: "BatchEditingRecoveryDemo"
captureNavigation: true
ownsNavigation: false
apis: ["List(selection:)", "confirmationDialog", "sheet", "EditMode"]
tags: ["batch", "selection", "confirmation", "delete", "undo", "move"]
---

# Batch actions and recovery

A selection flow groups related actions, confirms destructive changes, and offers a direct undo.

## SwiftUI

```swift
import SwiftUI

struct RecoverableBatchDelete: View {
    @State private var items = ["Quiet mornings", "Open water"]
    @State private var selection: Set<String> = []
    @State private var removed: [String] = []

    var body: some View {
        VStack {
            List(items, id: \.self, selection: $selection) { Text($0) }
                .environment(\.editMode, .constant(.active))
            Button("Delete selected", role: .destructive) {
                removed = items.filter { selection.contains($0) }
                items.removeAll { selection.contains($0) }
                selection = []
            }
            Button("Undo") { items.append(contentsOf: removed); removed = [] }
                .disabled(removed.isEmpty)
        }
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Batch actions and recovery on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792770513.48.png)
<!-- captures:end -->

## Example notes

All changes stay in this example; no account or remote data is modified.

## Full example

[Open the complete runnable example](BatchEditingRecoveryDemo.swift).

## Reference

[Apple: Form](https://developer.apple.com/documentation/swiftui/form).

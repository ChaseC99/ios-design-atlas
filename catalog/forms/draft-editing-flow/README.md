---
id: "draft-editing-flow"
title: "Draft editing and unsaved changes"
summary: "Editing a separate draft lets Save commit changes and Cancel discard them deliberately."
category: "Forms"
family: "Forms"
order: 2502
kind: "native"
demoMinIOS: "18.0"
swiftFile: "DraftEditingFlowDemo.swift"
view: "DraftEditingFlowDemo"
captureNavigation: false
ownsNavigation: false
apis: ["sheet", "interactiveDismissDisabled", "confirmationDialog", "ToolbarItem"]
tags: ["create", "edit", "save", "cancel", "unsaved changes"]
---

# Draft editing and unsaved changes

Editing a separate draft lets Save commit changes and Cancel discard them deliberately.

## SwiftUI

```swift
import SwiftUI

struct DraftEditor: View {
    @State private var saved = "Weekend plans"
    @State private var draft = ""
    @State private var editing = false

    var body: some View {
        Button(saved) { draft = saved; editing = true }
            .sheet(isPresented: $editing) {
                NavigationStack {
                    Form { TextField("Title", text: $draft) }
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Cancel") { editing = false }
                            }
                            ToolbarItem(placement: .confirmationAction) {
                                Button("Save") { saved = draft; editing = false }
                            }
                        }
                }
            }
    }
}
```

## Captures

<!-- captures:start -->
<!-- captures:end -->

## Example notes

All changes stay in this example; no account or remote data is modified.

## Full example

[Open the complete runnable example](DraftEditingFlowDemo.swift).

## Reference

[Apple: Form](https://developer.apple.com/documentation/swiftui/form).

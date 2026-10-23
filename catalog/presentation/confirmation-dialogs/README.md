---
id: "confirmation-dialogs"
title: "Confirmation dialogs"
summary: "Related actions, attached to their context."
category: "Presentation"
family: "Dialogs"
order: 3
kind: "native"
demoMinIOS: "18.0"
swiftFile: "ConfirmationDialogsDemo.swift"
view: "ConfirmationDialogsDemo"
apis: ["confirmationDialog", "ButtonRole"]
tags: ["actions", "adaptive", "destructive"]
captureNavigation: false
captureStyle: "screen"
---

# Confirmation dialogs

A confirmation dialog offers actions for a selected item, separating destructive choices from cancellation.

## SwiftUI

```swift
import SwiftUI

struct PhotoActions: View {
    @State private var showing = false
    var body: some View {
        Button("Photo actions") { showing = true }
            .confirmationDialog("Choose an action",
                                isPresented: $showing,
                                titleVisibility: .visible) {
                Button("Save a Copy") { /* Save the copy. */ }
                Button("Delete", role: .destructive) { /* Delete. */ }
                Button("Cancel", role: .cancel) { }
            }
    }
}
```

## Captures

<!-- captures:start -->
<!-- captures:end -->

## Full example

[Open the complete runnable example](ConfirmationDialogsDemo.swift).

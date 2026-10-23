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
captureReadyLabel: "Save a Copy"
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
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Confirmation dialogs on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792764284.519.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Confirmation dialogs on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792763819.898.png)

### iPhone 18 Pro · iOS 27.0

default. light appearance; Large text; en_US.

![Confirmation dialogs on iPhone 18 Pro, iOS 27.0](captures/ios-27-0-iphone-18-pro-default-1792764070.03.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](ConfirmationDialogsDemo.swift).

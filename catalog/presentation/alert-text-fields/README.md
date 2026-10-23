---
id: "alert-text-fields"
title: "Alert text fields"
summary: "A small edit without leaving the task."
category: "Presentation"
family: "Alerts"
order: 2
kind: "native"
captureNavigation: false
captureStyle: "isolated"
demoMinIOS: "18.0"
swiftFile: "AlertTextFieldsDemo.swift"
view: "AlertTextFieldsDemo"
apis: ["alert", "TextField", "disabled"]
tags: ["editing", "keyboard", "validation"]
---

# Alert text fields

An alert can include a text field for a small, focused edit, such as renaming an item.

## SwiftUI

```swift
import SwiftUI

struct RenameAlert: View {
    @State private var isPresented = false
    @State private var name = "Weekend references"
    @State private var draft = ""

    var body: some View {
        Button("Rename collection") {
            draft = name
            isPresented = true
        }
        .alert("Rename collection",
               isPresented: $isPresented) {
            TextField("Collection name", text: $draft)
            Button("Save") {
                name = draft.trimmingCharacters(
                    in: .whitespacesAndNewlines
                )
            }
            .disabled(draft.trimmingCharacters(
                in: .whitespacesAndNewlines
            ).isEmpty)
            Button("Cancel", role: .cancel) { }
        }
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 18 Pro · iOS 27.0

Rename alert; isolated presentation; software keyboard hidden. light appearance; Large text; en_US.

![Alert text fields on iPhone 18 Pro, iOS 27.0](captures/ios-27-0-iphone-18-pro-clean-1792760510.971.png)

### iPhone 16 Pro · iOS 18.5

Rename alert; isolated presentation; software keyboard hidden. light appearance; Large text; en_US.

![Alert text fields on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-clean-1792762066.927.png)

### iPhone 17 Pro · iOS 26.5

Rename alert; isolated presentation; software keyboard hidden. light appearance; Large text; en_US.

![Alert text fields on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-clean-1792762202.542.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](AlertTextFieldsDemo.swift).

## Reference

[Apple: alerts](https://developer.apple.com/design/human-interface-guidelines/alerts).

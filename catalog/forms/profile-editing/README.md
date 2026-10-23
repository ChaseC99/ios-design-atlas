---
id: "profile-editing"
title: "Profile editing"
summary: "An editable profile keeps its draft separate from the saved summary and offers an explicit way to reset changes."
category: "Forms"
family: "Forms"
order: 2506
kind: "native"
demoMinIOS: "18.0"
swiftFile: "ProfileEditingDemo.swift"
view: "ProfileEditingDemo"
captureNavigation: true
ownsNavigation: false
apis: ["Form", "TextField", "ColorPicker", "toolbar"]
tags: ["profile", "avatar", "save", "cancel", "account"]
---

# Profile editing

An editable profile keeps its draft separate from the saved summary and offers an explicit way to reset changes.

## SwiftUI

```swift
import SwiftUI

struct EditableProfile: View {
    @State private var savedName = "Avery Morgan"
    @State private var name = "Avery Morgan"

    var body: some View {
        Form {
            TextField("Display name", text: $name).textContentType(.name)
            Button("Save") { savedName = name }
            Button("Reset") { name = savedName }
        }
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Profile editing on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792770900.664.png)
<!-- captures:end -->

## Example notes

All changes stay in this example; no account or remote data is modified.

## Full example

[Open the complete runnable example](ProfileEditingDemo.swift).

## Reference

[Apple: Form](https://developer.apple.com/documentation/swiftui/form).

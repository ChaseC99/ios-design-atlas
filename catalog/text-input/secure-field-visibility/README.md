---
id: "secure-field-visibility"
title: "Password visibility"
summary: "A secure field obscures a password while an explicit visibility control lets the person check their entry."
category: "Text input"
family: "Fields"
order: 1302
kind: "native"
demoMinIOS: "18.0"
swiftFile: "SecureFieldVisibilityDemo.swift"
view: "SecureFieldVisibilityDemo"
captureNavigation: true
ownsNavigation: false
captureKeyboard: true
captureAction: "tap"
captureState: "Local sample password revealed with the visibility control; software keyboard open."
apis: ["SecureField", "FocusState", "textContentType"]
tags: ["password", "visibility", "autofill"]
---

# Password visibility

A secure field obscures a password while an explicit visibility control lets the person check their entry.

## SwiftUI

```swift
import SwiftUI

struct PasswordField: View {
    private enum Field: Hashable { case hidden, visible }
    @State private var password = ""
    @State private var visible = false
    @FocusState private var focus: Field?

    var body: some View {
        HStack {
            Group {
                if visible {
                    TextField("Password", text: $password).focused($focus, equals: .visible)
                } else {
                    SecureField("Password", text: $password).focused($focus, equals: .hidden)
                }
            }
            .textContentType(.newPassword)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
            Button(visible ? "Hide password" : "Show password",
                   systemImage: visible ? "eye.slash" : "eye") {
                let wasFocused = focus != nil
                visible.toggle()
                if wasFocused { focus = visible ? .visible : .hidden }
            }
            .labelStyle(.iconOnly)
        }
        .padding()
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 16 Pro · iOS 18.5

Local sample password revealed with the visibility control; software keyboard open.. light appearance; Large text; en_US.

![Password visibility on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792769266.915.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](SecureFieldVisibilityDemo.swift).

## Reference

[Apple: SecureField](https://developer.apple.com/documentation/swiftui/securefield).

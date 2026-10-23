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
apis: ["SecureField", "FocusState", "textContentType"]
tags: ["password", "visibility", "autofill"]
---

# Password visibility

A secure field obscures a password while an explicit visibility control lets the person check their entry.

## SwiftUI

```swift
import SwiftUI

struct PasswordField: View {
    @State private var password = ""
    @State private var visible = false

    var body: some View {
        HStack {
            Group {
                if visible { TextField("Password", text: $password) }
                else { SecureField("Password", text: $password) }
            }
            .textContentType(.password)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
            Button(visible ? "Hide password" : "Show password",
                   systemImage: visible ? "eye.slash" : "eye") {
                visible.toggle()
            }
            .labelStyle(.iconOnly)
        }
        .padding()
    }
}
```

## Captures

<!-- captures:start -->
<!-- captures:end -->

## Full example

[Open the complete runnable example](SecureFieldVisibilityDemo.swift).

## Reference

[Apple: SecureField](https://developer.apple.com/documentation/swiftui/securefield).

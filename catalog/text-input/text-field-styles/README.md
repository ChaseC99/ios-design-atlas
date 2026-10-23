---
id: "text-field-styles"
title: "Text-field styles and labels"
summary: "Persistent labels remain visible while a person enters text, and field styles establish the editing surface."
category: "Text input"
family: "Fields"
order: 1301
kind: "native"
demoMinIOS: "18.0"
swiftFile: "TextFieldStylesDemo.swift"
view: "TextFieldStylesDemo"
captureNavigation: true
ownsNavigation: false
captureKeyboard: true
apis: ["TextField", "textFieldStyle", "textContentType"]
tags: ["labels", "placeholder", "clear button", "adornments"]
---

# Text-field styles and labels

Persistent labels remain visible while a person enters text, and field styles establish the editing surface.

## SwiftUI

```swift
import SwiftUI

struct LabeledTextField: View {
    @State private var name = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Display name").font(.caption).foregroundStyle(.secondary)
            TextField("Your name", text: $name)
                .textContentType(.name)
                .textFieldStyle(.roundedBorder)
        }
        .padding()
    }
}
```

## Captures

<!-- captures:start -->
<!-- captures:end -->

## Full example

[Open the complete runnable example](TextFieldStylesDemo.swift).

## Reference

[Apple: TextField](https://developer.apple.com/documentation/swiftui/textfield).

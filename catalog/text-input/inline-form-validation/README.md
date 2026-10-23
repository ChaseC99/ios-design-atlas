---
id: "inline-form-validation"
title: "Inline validation"
summary: "Field-specific feedback explains what needs attention without discarding the person’s input."
category: "Text input"
family: "Validation"
order: 1308
kind: "native"
demoMinIOS: "18.0"
swiftFile: "InlineFormValidationDemo.swift"
view: "InlineFormValidationDemo"
captureNavigation: true
ownsNavigation: false
captureKeyboard: true
apis: ["TextField", "FocusState", "disabled"]
tags: ["required", "optional", "email", "validation", "save"]
---

# Inline validation

Field-specific feedback explains what needs attention without discarding the person’s input.

## SwiftUI

```swift
import SwiftUI

struct RequiredField: View {
    @State private var name = ""
    @State private var attempted = false
    private var valid: Bool { !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }

    var body: some View {
        Form {
            TextField("Collection name", text: $name)
            if attempted && !valid {
                Label("Enter a collection name", systemImage: "exclamationmark.circle")
                    .font(.footnote).foregroundStyle(.red)
            }
            Button("Save") { attempted = true }
        }
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Inline validation on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792770693.079.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](InlineFormValidationDemo.swift).

## Reference

[Apple: TextField](https://developer.apple.com/documentation/swiftui/textfield).

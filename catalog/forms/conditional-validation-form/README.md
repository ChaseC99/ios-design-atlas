---
id: "conditional-validation-form"
title: "Conditional forms and validation"
summary: "Required fields and conditional questions make the form respond to the choices already made."
category: "Forms"
family: "Forms"
order: 2503
kind: "native"
demoMinIOS: "18.0"
swiftFile: "ConditionalValidationFormDemo.swift"
view: "ConditionalValidationFormDemo"
captureNavigation: true
ownsNavigation: false
apis: ["Form", "Picker", "Stepper", "onChange"]
tags: ["required", "optional", "dependent", "inline validation", "submit validation"]
---

# Conditional forms and validation

Required fields and conditional questions make the form respond to the choices already made.

## SwiftUI

```swift
import SwiftUI

struct ConditionalGuestForm: View {
    @State private var attending = true
    @State private var guests = 1
    @State private var notes = ""

    var body: some View {
        Form {
            Toggle("I’ll be there", isOn: $attending)
            if attending {
                Stepper("Guests: \(guests)", value: $guests, in: 1...6)
                TextField("Dietary notes · optional", text: $notes, axis: .vertical)
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

[Open the complete runnable example](ConditionalValidationFormDemo.swift).

## Reference

[Apple: Form](https://developer.apple.com/documentation/swiftui/form).

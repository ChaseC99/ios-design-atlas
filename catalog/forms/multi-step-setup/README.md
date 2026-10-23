---
id: "multi-step-setup"
title: "Multi-step forms"
summary: "A small sequence keeps progress visible while preserving earlier answers."
category: "Forms"
family: "Flows"
order: 2504
kind: "native"
demoMinIOS: "18.0"
swiftFile: "MultiStepSetupDemo.swift"
view: "MultiStepSetupDemo"
captureNavigation: true
ownsNavigation: false
apis: ["ProgressView", "Form", "safeAreaInset", "Button"]
tags: ["wizard", "progress", "back", "validation", "persistent actions"]
---

# Multi-step forms

A small sequence keeps progress visible while preserving earlier answers.

## SwiftUI

```swift
import SwiftUI

struct ThreeStepForm: View {
    @State private var step = 0
    @State private var name = ""

    var body: some View {
        VStack {
            ProgressView(value: Double(step + 1), total: 3)
            Form {
                if step == 0 { TextField("Name", text: $name) }
                else if step == 1 { Text("Choose your preferences") }
                else { Text("Review: \(name)") }
            }
            HStack {
                Button("Back") { step -= 1 }.disabled(step == 0)
                Spacer()
                Button("Continue") { step += 1 }.disabled(step == 2 || name.isEmpty)
            }
        }
        .padding()
    }
}
```

## Captures

<!-- captures:start -->
<!-- captures:end -->

## Example notes

All changes stay in this example; no account or remote data is modified.

## Full example

[Open the complete runnable example](MultiStepSetupDemo.swift).

## Reference

[Apple: Form](https://developer.apple.com/documentation/swiftui/form).

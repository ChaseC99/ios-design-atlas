---
id: "repeating-buttons"
title: "Repeating buttons"
summary: "Let a held action continue at the system’s pace."
category: "Buttons"
family: "Buttons"
order: 1104
kind: "native"
demoMinIOS: "18.0"
swiftFile: "RepeatingButtonsDemo.swift"
view: "RepeatingButtonsDemo"
apis: ["buttonRepeatBehavior", "disabled", "monospacedDigit"]
tags: ["repeat", "press-and-hold", "increment"]
captureNavigation: true
captureStyle: "screen"
---

# Repeating buttons

A repeating button performs its action while it remains pressed. This is useful for small bounded adjustments, with disabled states at the limits and an accessible value that explains the current setting.

## SwiftUI

```swift
import SwiftUI

struct RepeatingButtonRecipe: View {
    @State private var servings = 2
    var body: some View {
        HStack {
            Text("Servings: \(servings)").monospacedDigit()
            Button("Add serving", systemImage: "plus") { servings += 1 }
                .buttonRepeatBehavior(.enabled)
                .disabled(servings >= 12)
        }
    }
}
```

## Captures

<!-- captures:start -->
Captures have not been recorded yet.
<!-- captures:end -->

## Full example

[Open the complete runnable example](RepeatingButtonsDemo.swift).

## Reference

[Apple: buttons](https://developer.apple.com/design/human-interface-guidelines/buttons).

---
id: "button-styles"
title: "Native button styles"
summary: "Compare emphasis, size, and shape."
category: "Buttons"
family: "Buttons"
order: 1101
kind: "native"
demoMinIOS: "18.0"
swiftFile: "NativeButtonStylesDemo.swift"
view: "NativeButtonStylesDemo"
apis: ["buttonStyle", "controlSize", "buttonBorderShape"]
tags: ["plain", "bordered", "prominent", "size", "shape"]
captureNavigation: true
captureStyle: "screen"
---

# Native button styles

Native button styles express emphasis while preserving system interaction and accessibility. Control size and border shape adjust the treatment without replacing the button’s built-in behavior.

## SwiftUI

```swift
import SwiftUI

struct NativeButtonStylesRecipe: View {
    @State private var saved = false
    var body: some View {
        Button(saved ? "Saved" : "Save collection") { saved.toggle() }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .buttonBorderShape(.capsule)
    }
}
```

## Captures

<!-- captures:start -->
Captures have not been recorded yet.
<!-- captures:end -->

## Full example

[Open the complete runnable example](NativeButtonStylesDemo.swift).

## Reference

[Apple: buttons](https://developer.apple.com/design/human-interface-guidelines/buttons).

---
id: "toggle-styles"
title: "Toggles and labels"
summary: "Make a persistent choice clear."
category: "Controls"
family: "Toggles"
order: 1202
kind: "native"
demoMinIOS: "18.0"
swiftFile: "ToggleStylesDemo.swift"
view: "ToggleStylesDemo"
apis: ["Toggle", "toggleStyle", "labelsHidden"]
tags: ["switch", "button", "labels", "selection"]
captureNavigation: true
captureStyle: "screen"
---

# Toggles and labels

A toggle represents a persistent on-or-off value. Switch and button styles suit different layouts, while labels keep the meaning clear even when the visual treatment shows only a symbol.

## SwiftUI

```swift
import SwiftUI

struct ToggleStylesRecipe: View {
    @State private var favorite = false
    var body: some View {
        Toggle(isOn: $favorite) {
            Label("Favorite", systemImage: "star")
        }
        .toggleStyle(.button)
    }
}
```

## Captures

<!-- captures:start -->
Captures have not been recorded yet.
<!-- captures:end -->

## Full example

[Open the complete runnable example](ToggleStylesDemo.swift).

## Reference

[Apple: pickers](https://developer.apple.com/design/human-interface-guidelines/pickers).

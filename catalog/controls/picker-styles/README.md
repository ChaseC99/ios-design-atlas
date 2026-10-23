---
id: "picker-styles"
title: "Picker styles"
summary: "Choose a value with the presentation that fits."
category: "Controls"
family: "Pickers"
order: 1201
kind: "native"
demoMinIOS: "18.0"
swiftFile: "PickerStylesDemo.swift"
view: "PickerStylesDemo"
apis: ["Picker", "pickerStyle", "navigationLink"]
tags: ["segmented", "menu", "wheel", "inline", "long-labels"]
captureNavigation: true
captureStyle: "screen"
---

# Picker styles

A picker binds one selection to a set of tagged values. Its style changes how the choices appear, from compact segments and menus to inline rows, a wheel, or a separate navigation destination.

## SwiftUI

```swift
import SwiftUI

struct PickerStylesRecipe: View {
    @State private var pace = "Relaxed"
    var body: some View {
        Picker("Walking pace", selection: $pace) {
            Text("Relaxed").tag("Relaxed")
            Text("Steady").tag("Steady")
            Text("Brisk").tag("Brisk")
        }
        .pickerStyle(.segmented)
    }
}
```

## Captures

<!-- captures:start -->
Captures have not been recorded yet.
<!-- captures:end -->

## Full example

[Open the complete runnable example](PickerStylesDemo.swift).

## Reference

[Apple: pickers](https://developer.apple.com/design/human-interface-guidelines/pickers).

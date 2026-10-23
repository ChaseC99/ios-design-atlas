---
id: "color-pickers"
title: "Color pickers"
summary: "Choose a color and optional opacity."
category: "Controls"
family: "Values"
order: 1206
kind: "native"
demoMinIOS: "18.0"
swiftFile: "ColorPickersDemo.swift"
view: "ColorPickersDemo"
apis: ["ColorPicker", "supportsOpacity", "Color"]
tags: ["color", "opacity", "well", "tint"]
captureNavigation: true
captureStyle: "screen"
---

# Color pickers

A color picker opens the system color-selection interface and binds the result to your content. Optional opacity controls are useful when transparency is part of the design; hide them when the task requires an opaque color.

## SwiftUI

```swift
import SwiftUI

struct ColorPickerRecipe: View {
    @State private var color = Color.teal
    var body: some View {
        VStack(spacing: 24) {
            RoundedRectangle(cornerRadius: 24).fill(color).frame(height: 160)
            ColorPicker("Collection color", selection: $color, supportsOpacity: true)
        }.padding()
    }
}
```

## Captures

<!-- captures:start -->
Captures have not been recorded yet.
<!-- captures:end -->

## Full example

[Open the complete runnable example](ColorPickersDemo.swift).

## Reference

[Apple: pickers](https://developer.apple.com/design/human-interface-guidelines/pickers).

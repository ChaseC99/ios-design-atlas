---
id: "button-labels"
title: "Button labels and width"
summary: "Keep the action clear at every size."
category: "Buttons"
family: "Buttons"
order: 1102
kind: "native"
demoMinIOS: "18.0"
swiftFile: "ButtonLabelsDemo.swift"
view: "ButtonLabelsDemo"
apis: ["Label", "labelStyle", "frame", "accessibilityLabel"]
tags: ["icons", "labels", "full-width", "hit-target"]
captureNavigation: true
captureStyle: "screen"
---

# Button labels and width

A button’s label can show text, a symbol, or both. Give icon-only actions an accessible name, and place an expanding frame inside the label when the entire available width should be tappable.

## SwiftUI

```swift
import SwiftUI

struct ButtonLabelsRecipe: View {
    @State private var isSaved = false
    var body: some View {
        Button { isSaved.toggle() } label: {
            Label(isSaved ? "Saved" : "Save collection", systemImage: "bookmark")
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(.borderedProminent)
        .controlSize(.large)
    }
}
```

## Captures

<!-- captures:start -->
Captures have not been recorded yet.
<!-- captures:end -->

## Full example

[Open the complete runnable example](ButtonLabelsDemo.swift).

## Reference

[Apple: buttons](https://developer.apple.com/design/human-interface-guidelines/buttons).

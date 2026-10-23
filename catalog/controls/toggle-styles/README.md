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
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Toggles and labels on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792766921.16.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Toggles and labels on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792766650.809.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](ToggleStylesDemo.swift).

## Reference

[Apple: pickers](https://developer.apple.com/design/human-interface-guidelines/pickers).

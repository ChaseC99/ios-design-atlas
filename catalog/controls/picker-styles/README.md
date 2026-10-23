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
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Picker styles on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792766331.922.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Picker styles on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792766138.902.png)

### iPhone 18 Pro · iOS 27.0

default. light appearance; Large text; en_US.

![Picker styles on iPhone 18 Pro, iOS 27.0](captures/ios-27-0-iphone-18-pro-default-1792768288.149.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](PickerStylesDemo.swift).

## Reference

[Apple: pickers](https://developer.apple.com/design/human-interface-guidelines/pickers).

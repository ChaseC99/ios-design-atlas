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
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Button labels and width on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792765467.772.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Button labels and width on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792765370.205.png)

### iPhone 18 Pro · iOS 27.0

default. light appearance; Large text; en_US.

![Button labels and width on iPhone 18 Pro, iOS 27.0](captures/ios-27-0-iphone-18-pro-default-1792767596.633.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](ButtonLabelsDemo.swift).

## Reference

[Apple: buttons](https://developer.apple.com/design/human-interface-guidelines/buttons).

---
id: "overlays-and-modifier-order"
title: "Overlays and modifier order"
summary: "Change the decoration without changing the same bounds."
category: "Layout"
family: "Composition"
order: 1704
kind: "custom"
demoMinIOS: "18.0"
swiftFile: "OverlayModifierOrderDemo.swift"
view: "OverlayModifierOrderDemo"
apis: ["overlay", "background", "padding", "ZStack"]
tags: ["overlay", "stack", "modifier-order", "bounds"]
captureNavigation: true
captureStyle: "screen"
---

# Overlays and modifier order

An overlay decorates a view without taking space beside it, while a stack makes each child part of the layout. Modifier order also changes which bounds a background or border sees, so the same padding can produce a different visual result.

## SwiftUI

```swift
import SwiftUI

struct ModifierOrderRecipe: View {

    var body: some View {
        VStack(spacing: 24) {
            Text("Padding first")
                .padding(20)
                .background(.teal.opacity(0.15))
            Text("Background first")
                .background(.teal.opacity(0.15))
                .padding(20)
        }
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Overlays and modifier order on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792766305.321.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Overlays and modifier order on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792766117.601.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](OverlayModifierOrderDemo.swift).

## Reference

[Apple: layout](https://developer.apple.com/design/human-interface-guidelines/layout).

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
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Native button styles on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792765479.935.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Native button styles on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792765386.132.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](NativeButtonStylesDemo.swift).

## Reference

[Apple: buttons](https://developer.apple.com/design/human-interface-guidelines/buttons).

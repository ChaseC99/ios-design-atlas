---
id: "custom-button-styles"
title: "Custom button styles"
summary: "Add a visual identity while keeping a real button."
category: "Buttons"
family: "Buttons"
order: 1108
kind: "custom"
demoMinIOS: "18.0"
swiftFile: "CustomButtonStylesDemo.swift"
view: "CustomButtonStylesDemo"
apis: ["ButtonStyle", "isPressed", "contentShape", "accessibilityReduceMotion"]
tags: ["custom", "pressed", "disabled", "accessibility", "hit-target"]
captureNavigation: true
captureStyle: "screen"
---

# Custom button styles

A custom button style changes the visual response to pressing while retaining a native button’s action and accessibility semantics. Give the label a comfortable hit area and reflect disabled state and Reduce Motion in the style.

## SwiftUI

```swift
import SwiftUI

struct CustomButtonRecipe: View {
    @State private var saved = false
    var body: some View {
        Button(saved ? "Saved" : "Save") { saved.toggle() }
            .buttonStyle(SoftButtonRecipeStyle())
    }
}

private struct SoftButtonRecipeStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, 24).frame(minHeight: 48)
            .background(.tint.opacity(configuration.isPressed ? 0.25 : 0.12), in: Capsule())
            .contentShape(Capsule())
            .opacity(isEnabled ? 1 : 0.4)
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Custom button styles on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792765570.371.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Custom button styles on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792765490.885.png)

### iPhone 18 Pro · iOS 27.0

default. light appearance; Large text; en_US.

![Custom button styles on iPhone 18 Pro, iOS 27.0](captures/ios-27-0-iphone-18-pro-default-1792767723.123.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](CustomButtonStylesDemo.swift).

## Reference

[Apple: buttons](https://developer.apple.com/design/human-interface-guidelines/buttons).

---
id: "menu-primary-actions"
title: "Menus with a primary action"
summary: "Offer a quick tap and more choices on a long press."
category: "Buttons"
family: "Menus"
order: 1106
kind: "native"
demoMinIOS: "18.0"
swiftFile: "MenuPrimaryActionsDemo.swift"
view: "MenuPrimaryActionsDemo"
apis: ["Menu", "primaryAction"]
tags: ["primary-action", "long-press", "secondary-actions"]
captureNavigation: false
captureStyle: "screen"
captureAction: "longPress"
captureReadyLabel: "Save a copy"
---

# Menus with a primary action

A menu with a primary action performs its most common operation on a tap and reveals secondary actions on a long press. Its label should make the quick action clear while keeping related alternatives nearby.

## SwiftUI

```swift
import SwiftUI

struct PrimaryMenuRecipe: View {
    @State private var saved = false
    var body: some View {
        Menu {
            Button("Save a copy") { saved = true }
            Button("Remove saved item", role: .destructive) { saved = false }
        } label: {
            Label(saved ? "Saved" : "Save", systemImage: "bookmark")
        } primaryAction: {
            saved.toggle()
        }
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Menus with a primary action on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792766160.731.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Menus with a primary action on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792765964.294.png)

### iPhone 18 Pro · iOS 27.0

default. light appearance; Large text; en_US.

![Menus with a primary action on iPhone 18 Pro, iOS 27.0](captures/ios-27-0-iphone-18-pro-default-1792768155.842.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](MenuPrimaryActionsDemo.swift).

## Reference

[Apple: menus](https://developer.apple.com/design/human-interface-guidelines/menus).

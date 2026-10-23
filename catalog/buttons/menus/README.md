---
id: "menus"
title: "Sections and nested menus"
summary: "Gather related actions into a compact menu."
category: "Buttons"
family: "Menus"
order: 1105
kind: "native"
demoMinIOS: "18.0"
swiftFile: "NativeMenusDemo.swift"
view: "NativeMenusDemo"
apis: ["Menu", "Section", "Picker", "menuOrder"]
tags: ["sections", "nested", "roles", "selection"]
captureNavigation: false
captureStyle: "screen"
captureAction: "tap"
captureReadyLabel: "Open collection"
---

# Sections and nested menus

A menu groups related actions in a small contextual surface. Sections separate tasks, nested menus organize secondary choices, and a picker marks the current value without requiring a custom selection indicator.

## SwiftUI

```swift
import SwiftUI

struct NativeMenuRecipe: View {
    @State private var sort = "Newest"
    var body: some View {
        Menu("Collection actions", systemImage: "ellipsis.circle") {
            Button("Open collection") { /* Open the selected collection. */ }
            Menu("Sort by") {
                Picker("Sort order", selection: $sort) {
                    Text("Newest").tag("Newest")
                    Text("Title").tag("Title")
                }
            }
            Button("Delete", role: .destructive) { /* Delete after confirming intent. */ }
        }
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Sections and nested menus on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792766169.571.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Sections and nested menus on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792765974.908.png)

### iPhone 18 Pro · iOS 27.0

default. light appearance; Large text; en_US.

![Sections and nested menus on iPhone 18 Pro, iOS 27.0](captures/ios-27-0-iphone-18-pro-default-1792768167.229.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](NativeMenusDemo.swift).

## Reference

[Apple: menus](https://developer.apple.com/design/human-interface-guidelines/menus).

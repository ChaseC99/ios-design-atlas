---
id: "toolbar-menus"
title: "Toolbar menus"
summary: "Group secondary actions without crowding the bar."
category: "Toolbars"
family: "Actions"
order: 504
kind: "native"
demoMinIOS: "18.0"
swiftFile: "ToolbarMenusDemo.swift"
view: "ToolbarMenusDemo"
captureNavigation: true
ownsNavigation: false
captureStyle: "screen"
apis: ["Menu", "Picker", "ToolbarItem"]
tags: ["nested menu", "sorting", "secondary actions"]
---

# Toolbar menus

A toolbar menu keeps less frequent actions close at hand and can contain sections, nested menus, and selection controls.

## SwiftUI

```swift
import SwiftUI

struct MenuToolbar: View {
    @State private var sort = "Name"
    var body: some View {
        Text("Collections").toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Menu {
                    Button("New collection", systemImage: "folder.badge.plus") { }
                    Menu("Sort by") {
                        Picker("Order", selection: $sort) {
                            Text("Name").tag("Name")
                            Text("Added").tag("Added")
                        }
                    }
                } label: { Label("Actions", systemImage: "ellipsis") }
            }
        }
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Toolbar menus on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792766934.67.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Toolbar menus on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792766672.059.png)

### iPhone 18 Pro · iOS 27.0

default. light appearance; Large text; en_US.

![Toolbar menus on iPhone 18 Pro, iOS 27.0](captures/ios-27-0-iphone-18-pro-default-1792768825.32.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](ToolbarMenusDemo.swift).

## Reference

[Apple: Menu](https://developer.apple.com/documentation/swiftui/menu).

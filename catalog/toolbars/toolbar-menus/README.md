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
<!-- captures:end -->

## Full example

[Open the complete runnable example](ToolbarMenusDemo.swift).

## Reference

[Apple: Menu](https://developer.apple.com/documentation/swiftui/menu).

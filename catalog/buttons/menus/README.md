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
Captures have not been recorded yet.
<!-- captures:end -->

## Full example

[Open the complete runnable example](NativeMenusDemo.swift).

## Reference

[Apple: menus](https://developer.apple.com/design/human-interface-guidelines/menus).

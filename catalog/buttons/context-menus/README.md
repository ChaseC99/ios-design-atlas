---
id: "context-menus"
title: "Context menus and selection"
summary: "Attach actions to an item or a selected group."
category: "Buttons"
family: "Menus"
order: 1107
kind: "native"
demoMinIOS: "18.0"
swiftFile: "ContextMenusDemo.swift"
view: "ContextMenusDemo"
apis: ["contextMenu", "List", "selection", "contentShape"]
tags: ["preview", "selection", "multiple-items", "long-press"]
captureNavigation: false
captureStyle: "screen"
captureAction: "longPress"
captureReadyLabel: "Add to Favorites"
---

# Context menus and selection

A context menu attaches actions to the content they affect. A preview can preserve the item’s identity, while a selection-aware list menu receives the items targeted by the interaction so actions can work on one item or a group.

## SwiftUI

```swift
import SwiftUI

struct ContextMenuRecipe: View {
    @State private var favorite = false
    var body: some View {
        Label("Morning light", systemImage: "sun.horizon.fill")
            .padding(32)
            .contextMenu {
                Button(favorite ? "Remove favorite" : "Add favorite") { favorite.toggle() }
            } preview: {
                Image(systemName: "sun.horizon.fill")
                    .font(.system(size: 80)).padding(60)
            }
    }
}
```

## Captures

<!-- captures:start -->
Captures have not been recorded yet.
<!-- captures:end -->

## Full example

[Open the complete runnable example](ContextMenusDemo.swift).

## Reference

[Apple: menus](https://developer.apple.com/design/human-interface-guidelines/menus).

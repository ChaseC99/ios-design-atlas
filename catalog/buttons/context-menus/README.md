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
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Context menus and selection on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792765549.204.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Context menus and selection on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792765470.307.png)

### iPhone 18 Pro · iOS 27.0

default. light appearance; Large text; en_US.

![Context menus and selection on iPhone 18 Pro, iOS 27.0](captures/ios-27-0-iphone-18-pro-default-1792767703.409.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](ContextMenusDemo.swift).

## Reference

[Apple: menus](https://developer.apple.com/design/human-interface-guidelines/menus).

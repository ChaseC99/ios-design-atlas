---
id: "toolbar-placements"
title: "Toolbar placements"
summary: "Place actions at the top, bottom, or center of a navigation interface."
category: "Toolbars"
family: "Placement"
order: 501
kind: "native"
demoMinIOS: "18.0"
swiftFile: "ToolbarPlacementsDemo.swift"
view: "ToolbarPlacementsDemo"
captureNavigation: true
ownsNavigation: false
captureStyle: "screen"
apis: ["ToolbarItem", "ToolbarItemGroup", "ToolbarItemPlacement"]
tags: ["leading", "trailing", "bottom", "labels"]
---

# Toolbar placements

Toolbar placements describe an action’s role and preferred location, leaving the system to arrange it for the current device.

## SwiftUI

```swift
import SwiftUI

struct PlacedActions: View {
    @State private var saved = false
    var body: some View {
        Text("A quiet moment").navigationTitle("Study")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(saved ? "Unsave" : "Save",
                           systemImage: saved ? "bookmark.fill" : "bookmark") {
                        saved.toggle()
                    }
                }
                ToolbarItem(placement: .bottomBar) {
                    Text("1 of 3").foregroundStyle(.secondary)
                }
            }
    }
}
```

## Captures

<!-- captures:start -->
<!-- captures:end -->

## Full example

[Open the complete runnable example](ToolbarPlacementsDemo.swift).

## Reference

[Apple: ToolbarItem](https://developer.apple.com/documentation/swiftui/toolbaritemplacement).

---
id: "navigation-destination-states"
title: "Destination states"
summary: "Loading and unavailable views keep navigation usable when a destination has no content."
category: "Navigation"
family: "Stacks"
order: 308
kind: "native"
demoMinIOS: "18.0"
swiftFile: "NavigationDestinationStatesDemo.swift"
view: "NavigationDestinationStatesDemo"
captureNavigation: false
ownsNavigation: true
apis: ["ContentUnavailableView", "ProgressView", "task"]
tags: ["loading", "error", "retry", "unavailable"]
---

# Destination states

Loading and unavailable views keep navigation usable when a destination has no content.

## SwiftUI

```swift
import SwiftUI

struct UnavailableDestination: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("Open collection") {
                    ContentUnavailableView(
                        "Collection unavailable",
                        systemImage: "wifi.slash",
                        description: Text("Check your connection and try again.")
                    )
                    .navigationTitle("Collection")
                    .navigationBarTitleDisplayMode(.inline)
                }
            }
            .navigationTitle("Library")
        }
    }
}
```

## Captures

<!-- captures:start -->
<!-- captures:end -->

## Full example

[Open the complete runnable example](NavigationDestinationStatesDemo.swift).

## Reference

[Apple: ContentUnavailableView](https://developer.apple.com/documentation/swiftui/contentunavailableview).

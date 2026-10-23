---
id: "navigation-title-styles"
title: "Navigation titles"
summary: "Large and inline titles establish the hierarchy of a destination."
category: "Navigation"
family: "Titles"
order: 302
kind: "native"
demoMinIOS: "18.0"
swiftFile: "NavigationTitleStylesDemo.swift"
view: "NavigationTitleStylesDemo"
captureNavigation: false
ownsNavigation: true
apis: ["navigationTitle", "navigationBarTitleDisplayMode", "ToolbarItem"]
tags: ["large title", "inline title", "truncation"]
---

# Navigation titles

Large and inline titles establish the hierarchy of a destination.

## SwiftUI

```swift
import SwiftUI

struct JournalTitles: View {
    var body: some View {
        NavigationStack {
            List(1...30, id: \.self) { index in
                NavigationLink("Journal entry \(index)") {
                    Text("A quieter afternoon.")
                        .navigationTitle("Entry \(index)")
                        .navigationBarTitleDisplayMode(.inline)
                }
            }
            .navigationTitle("Journal")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}
```

## Captures

<!-- captures:start -->
<!-- captures:end -->

## Full example

[Open the complete runnable example](NavigationTitleStylesDemo.swift).

## Reference

[Apple: navigationTitle](https://developer.apple.com/documentation/swiftui/view/navigationbartitledisplaymode(_:)).

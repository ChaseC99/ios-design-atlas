---
id: "list-styles"
title: "List styles"
summary: "Plain, grouped, and inset-grouped lists organize the same rows in different ways."
category: "Lists"
family: "Structure"
order: 901
kind: "native"
demoMinIOS: "18.0"
swiftFile: "ListStylesDemo.swift"
view: "ListStylesDemo"
captureNavigation: true
ownsNavigation: false
apis: ["List", "listStyle", "Section"]
tags: ["plain", "grouped", "inset grouped", "headers", "footers"]
---

# List styles

Plain, grouped, and inset-grouped lists organize the same rows in different ways.

## SwiftUI

```swift
import SwiftUI

struct GroupedCollections: View {
    var body: some View {
        List {
            Section {
                Label("Morning rituals", systemImage: "sun.horizon")
                Label("Small adventures", systemImage: "leaf")
            } header: {
                Text("Pinned")
            } footer: {
                Text("Your favorites, always close by.")
            }
        }
        .listStyle(.insetGrouped)
    }
}
```

## Captures

<!-- captures:start -->
<!-- captures:end -->

## Full example

[Open the complete runnable example](ListStylesDemo.swift).

## Reference

[Apple: List](https://developer.apple.com/documentation/swiftui/list).

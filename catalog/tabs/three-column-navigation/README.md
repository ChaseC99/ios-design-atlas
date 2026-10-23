---
id: "three-column-navigation"
title: "Three-column navigation"
summary: "A three-column split view separates collections, items, and the selected detail."
category: "Tabs"
family: "Split views"
order: 408
kind: "native"
demoMinIOS: "18.0"
swiftFile: "ThreeColumnNavigationDemo.swift"
view: "ThreeColumnNavigationDemo"
captureNavigation: false
ownsNavigation: true
apis: ["NavigationSplitView", "navigationSplitViewColumnWidth", "navigationSplitViewStyle"]
tags: ["three columns", "sidebar", "content", "detail"]
---

# Three-column navigation

A three-column split view separates collections, items, and the selected detail.

## SwiftUI

```swift
import SwiftUI

struct ThreeColumnLibrary: View {
    @State private var folder: String?
    @State private var note: String?

    var body: some View {
        NavigationSplitView {
            List(["Personal", "Work"], id: \.self, selection: $folder) {
                NavigationLink($0, value: $0)
            }
        } content: {
            if let folder {
                List(["\(folder) notes", "Ideas"], id: \.self, selection: $note) {
                    NavigationLink($0, value: $0)
                }
            }
        } detail: {
            Text(note ?? "Choose a note")
        }
        .onChange(of: folder) { _, _ in note = nil }
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 18 Pro · iOS 27.0

default. light appearance; Large text; en_US.

![Three-column navigation on iPhone 18 Pro, iOS 27.0](captures/ios-27-0-iphone-18-pro-default-1792763113.932.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](ThreeColumnNavigationDemo.swift).

## Reference

[Apple: NavigationSplitView](https://developer.apple.com/documentation/swiftui/navigationsplitview).

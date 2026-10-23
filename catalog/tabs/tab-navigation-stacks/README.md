---
id: "tab-navigation-stacks"
title: "Independent tab stacks"
summary: "Each tab can keep its own navigation path while the user switches sections."
category: "Tabs"
family: "Tab bars"
order: 402
kind: "native"
demoMinIOS: "18.0"
swiftFile: "TabNavigationStacksDemo.swift"
view: "TabNavigationStacksDemo"
captureNavigation: false
ownsNavigation: true
apis: ["TabView", "NavigationStack", "Binding"]
tags: ["independent paths", "reselection", "pop to root"]
---

# Independent tab stacks

Each tab can keep its own navigation path while the user switches sections.

## SwiftUI

```swift
import SwiftUI

struct IndependentTabs: View {
    @State private var libraryPath: [String] = []
    @State private var savedPath: [String] = []

    var body: some View {
        TabView {
            Tab("Library", systemImage: "books.vertical") {
                NavigationStack(path: $libraryPath) {
                    NavigationLink("Open book", value: "A good book")
                        .navigationDestination(for: String.self) { Text($0) }
                }
            }
            Tab("Saved", systemImage: "bookmark") {
                NavigationStack(path: $savedPath) {
                    NavigationLink("Open note", value: "A saved note")
                        .navigationDestination(for: String.self) { Text($0) }
                }
            }
        }
    }
}
```

## Captures

<!-- captures:start -->
<!-- captures:end -->

## Full example

[Open the complete runnable example](TabNavigationStacksDemo.swift).

## Reference

[Apple: TabView](https://developer.apple.com/documentation/swiftui/tabview).

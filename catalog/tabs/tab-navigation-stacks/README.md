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
### iPhone 18 Pro · iOS 27.0

default. light appearance; Large text; en_US.

![Independent tab stacks on iPhone 18 Pro, iOS 27.0](captures/ios-27-0-iphone-18-pro-default-1792763104.588.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](TabNavigationStacksDemo.swift).

## Reference

[Apple: TabView](https://developer.apple.com/documentation/swiftui/tabview).

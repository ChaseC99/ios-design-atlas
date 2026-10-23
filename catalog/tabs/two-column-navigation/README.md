---
id: "two-column-navigation"
title: "Two-column navigation"
summary: "A split view presents a sidebar and a detail destination, collapsing into a stack in compact layouts."
category: "Tabs"
family: "Split views"
order: 407
kind: "native"
demoMinIOS: "18.0"
swiftFile: "TwoColumnNavigationDemo.swift"
view: "TwoColumnNavigationDemo"
captureNavigation: false
ownsNavigation: true
apis: ["NavigationSplitView", "NavigationSplitViewVisibility", "preferredCompactColumn"]
tags: ["two columns", "selection", "empty detail", "collapse"]
---

# Two-column navigation

A split view presents a sidebar and a detail destination, collapsing into a stack in compact layouts.

## SwiftUI

```swift
import SwiftUI

struct TwoColumnLibrary: View {
    @State private var selection: String?

    var body: some View {
        NavigationSplitView {
            List(["Travel", "Ideas"], id: \.self, selection: $selection) { title in
                NavigationLink(title, value: title)
            }
            .navigationTitle("Library")
        } detail: {
            if let selection {
                Text(selection)
            } else {
                ContentUnavailableView("Choose a collection", systemImage: "sidebar.left")
            }
        }
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 18 Pro · iOS 27.0

default. light appearance; Large text; en_US.

![Two-column navigation on iPhone 18 Pro, iOS 27.0](captures/ios-27-0-iphone-18-pro-default-1792763122.814.png)

### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Two-column navigation on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792766948.347.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Two-column navigation on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792766685.698.png)

### iPhone Duo · iOS 27.1

default. light appearance; Large text; en_US.

![Two-column navigation on iPhone Duo, iOS 27.1](captures/ios-27-1-atlas-iphone-duo-default-1792767950.21.png)

### iPad Pro 11-inch (M5) · iOS 27.0

Sidebar and intentional empty-detail prompt are both visible. Selected-detail behavior is not established.. light appearance; Large text; en_US.

![Two-column navigation on iPad Pro 11-inch (M5), iOS 27.0](captures/ios-27-0-ipad-pro-11-inch-m5-default-1792768634.906.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](TwoColumnNavigationDemo.swift).

## Reference

[Apple: NavigationSplitView](https://developer.apple.com/documentation/swiftui/navigationsplitview).

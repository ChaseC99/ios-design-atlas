---
id: "standard-tabs"
title: "Standard tabs"
summary: "A tab bar switches between the main sections of an app."
category: "Tabs"
family: "Tab bars"
order: 401
kind: "native"
demoMinIOS: "18.0"
swiftFile: "StandardTabsDemo.swift"
view: "StandardTabsDemo"
captureNavigation: false
ownsNavigation: true
apis: ["TabView", "Tab", "badge"]
tags: ["selection", "labels", "icons", "badges"]
---

# Standard tabs

A tab bar switches between the main sections of an app.

## SwiftUI

```swift
import SwiftUI

struct AppTabs: View {
    @State private var selection = 0

    var body: some View {
        TabView(selection: $selection) {
            Tab("Today", systemImage: "sun.max", value: 0) {
                Text("Today")
            }
            Tab("Inbox", systemImage: "tray", value: 1) {
                Text("Inbox")
            }
            .badge(3)
            Tab("Saved", systemImage: "bookmark", value: 2) {
                Text("Saved")
            }
        }
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 18 Pro · iOS 27.0

default. light appearance; Large text; en_US.

![Standard tabs on iPhone 18 Pro, iOS 27.0](captures/ios-27-0-iphone-18-pro-default-1792763076.759.png)

### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Standard tabs on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792766843.888.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Standard tabs on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792766543.734.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](StandardTabsDemo.swift).

## Reference

[Apple: TabView](https://developer.apple.com/documentation/swiftui/tabview).

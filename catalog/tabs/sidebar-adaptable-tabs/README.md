---
id: "sidebar-adaptable-tabs"
title: "Tabs that become a sidebar"
summary: "A sidebar-adaptable tab view organizes the same sections for compact and wide layouts."
category: "Tabs"
family: "Sidebars"
order: 406
kind: "native"
demoMinIOS: "18.0"
swiftFile: "SidebarAdaptableTabsDemo.swift"
view: "SidebarAdaptableTabsDemo"
captureNavigation: false
ownsNavigation: true
apis: ["sidebarAdaptable", "TabSection", "tabViewCustomization"]
tags: ["iPad", "customization", "sidebar", "sections"]
---

# Tabs that become a sidebar

A sidebar-adaptable tab view organizes the same sections for compact and wide layouts.

## SwiftUI

```swift
import SwiftUI

struct AdaptableTabs: View {
    @AppStorage("tabCustomization") private var customization = TabViewCustomization()

    var body: some View {
        TabView {
            Tab("Library", systemImage: "books.vertical") { Text("Library") }
                .customizationID("library")
            TabSection("Collections") {
                Tab("Travel", systemImage: "map") { Text("Travel") }
                    .customizationID("travel")
                Tab("Ideas", systemImage: "lightbulb") { Text("Ideas") }
                    .customizationID("ideas")
            }
        }
        .tabViewStyle(.sidebarAdaptable)
        .tabViewCustomization($customization)
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 18 Pro · iOS 27.0

default. light appearance; Large text; en_US.

![Tabs that become a sidebar on iPhone 18 Pro, iOS 27.0](captures/ios-27-0-iphone-18-pro-default-1792763058.763.png)

### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Tabs that become a sidebar on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792766801.738.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Tabs that become a sidebar on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792766478.388.png)

### iPhone Duo · iOS 27.1

default. light appearance; Large text; en_US.

![Tabs that become a sidebar on iPhone Duo, iOS 27.1](captures/ios-27-1-atlas-iphone-duo-default-1792767930.366.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](SidebarAdaptableTabsDemo.swift).

## Reference

[Apple: sidebarAdaptable](https://developer.apple.com/documentation/swiftui/sidebaradaptabletabviewstyle).

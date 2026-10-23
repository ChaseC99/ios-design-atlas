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
<!-- captures:end -->

## Full example

[Open the complete runnable example](SidebarAdaptableTabsDemo.swift).

## Reference

[Apple: sidebarAdaptable](https://developer.apple.com/documentation/swiftui/sidebaradaptabletabviewstyle).

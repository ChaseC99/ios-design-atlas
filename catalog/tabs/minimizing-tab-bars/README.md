---
id: "minimizing-tab-bars"
title: "Minimizing tab bars"
summary: "A tab bar can become compact as content scrolls and expand when the user returns."
category: "Tabs"
family: "Tab bars"
order: 404
kind: "native"
demoMinIOS: "26.0"
swiftFile: "MinimizingTabBarsDemo.swift"
view: "MinimizingTabBarsDemo"
captureNavigation: false
ownsNavigation: true
apis: ["tabBarMinimizeBehavior", "TabBarMinimizeBehavior", "TabView"]
tags: ["scroll", "minimize", "iOS 26"]
---

# Minimizing tab bars

A tab bar can become compact as content scrolls and expand when the user returns.

## SwiftUI

```swift
import SwiftUI

@available(iOS 26.0, *)
struct MinimizingTabs: View {
    var body: some View {
        TabView {
            Tab("Discover", systemImage: "sparkles") {
                NavigationStack {
                    List(1...50, id: \.self) { Text("Story \($0)") }
                        .navigationTitle("Discover")
                }
            }
            Tab("Saved", systemImage: "bookmark") {
                Text("Saved stories")
            }
        }
        .tabBarMinimizeBehavior(.onScrollDown)
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 18 Pro · iOS 27.0

default. light appearance; Large text; en_US.

![Minimizing tab bars on iPhone 18 Pro, iOS 27.0](captures/ios-27-0-iphone-18-pro-default-1792762774.122.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Minimizing tab bars on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792765982.412.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](MinimizingTabBarsDemo.swift).

## Reference

[Apple: tabBarMinimizeBehavior](https://developer.apple.com/documentation/swiftui/view/tabbarminimizebehavior(_:)).

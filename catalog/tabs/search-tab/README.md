---
id: "search-tab"
title: "Search tabs"
summary: "A dedicated search tab gives discovery its own place in the tab bar."
category: "Tabs"
family: "Tab bars"
order: 403
kind: "native"
demoMinIOS: "18.0"
swiftFile: "SearchTabDemo.swift"
view: "SearchTabDemo"
captureNavigation: false
ownsNavigation: true
apis: ["TabRole.search", "searchable", "ContentUnavailableView.search"]
tags: ["search", "query", "results"]
---

# Search tabs

A dedicated search tab gives discovery its own place in the tab bar.

## SwiftUI

```swift
import SwiftUI

struct SearchTabs: View {
    @State private var query = ""

    var body: some View {
        TabView {
            Tab("Explore", systemImage: "safari") {
                Text("Explore")
            }
            Tab("Search", systemImage: "magnifyingglass", role: .search) {
                NavigationStack {
                    List(["Big Sur", "Carmel"].filter {
                        query.isEmpty || $0.localizedCaseInsensitiveContains(query)
                    }, id: \.self) { Text($0) }
                    .navigationTitle("Search")
                }
                .searchable(text: $query)
            }
        }
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 18 Pro · iOS 27.0

default. light appearance; Large text; en_US.

![Search tabs on iPhone 18 Pro, iOS 27.0](captures/ios-27-0-iphone-18-pro-default-1792762946.234.png)

### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Search tabs on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792766646.149.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Search tabs on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792766429.882.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](SearchTabDemo.swift).

## Reference

[Apple: TabRole.search](https://developer.apple.com/documentation/swiftui/tabrole/search).

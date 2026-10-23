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
<!-- captures:end -->

## Full example

[Open the complete runnable example](SearchTabDemo.swift).

## Reference

[Apple: TabRole.search](https://developer.apple.com/documentation/swiftui/tabrole/search).

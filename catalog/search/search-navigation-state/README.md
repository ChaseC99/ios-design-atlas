---
id: "search-navigation-state"
title: "Search state during navigation"
summary: "Keeping the query in the search screen preserves its results when a detail destination closes."
category: "Search"
family: "Navigation"
order: 1408
kind: "native"
demoMinIOS: "18.0"
swiftFile: "SearchNavigationStateDemo.swift"
view: "SearchNavigationStateDemo"
captureNavigation: false
ownsNavigation: true
captureKeyboard: false
apis: ["NavigationStack", "navigationDestination", "searchable"]
tags: ["preserve query", "collection search", "navigation"]
---

# Search state during navigation

Keeping the query in the search screen preserves its results when a detail destination closes.

## SwiftUI

```swift
import SwiftUI

struct PersistentSearchScreen: View {
    @State private var query = ""
    private let notes = ["Coastal mornings", "Garden notebook"]

    var body: some View {
        NavigationStack {
            List(notes.filter { query.isEmpty || $0.localizedCaseInsensitiveContains(query) }, id: \.self) { title in
                NavigationLink(title, value: title)
            }
            .searchable(text: $query)
            .navigationDestination(for: String.self) { Text($0) }
        }
    }
}
```

## Captures

<!-- captures:start -->
<!-- captures:end -->

## Full example

[Open the complete runnable example](SearchNavigationStateDemo.swift).

## Reference

[Apple: NavigationStack](https://developer.apple.com/documentation/swiftui/navigationstack).

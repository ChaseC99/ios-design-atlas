---
id: "search-filters"
title: "Search filters"
summary: "Filters combine with a text query and expose the constraints that remain active."
category: "Search"
family: "Results"
order: 1405
kind: "native"
demoMinIOS: "18.0"
swiftFile: "SearchFiltersDemo.swift"
view: "SearchFiltersDemo"
captureNavigation: true
ownsNavigation: false
captureKeyboard: false
apis: ["searchable", "sheet", "Picker", "Toggle"]
tags: ["filters", "active filters", "sort", "summary"]
---

# Search filters

Filters combine with a text query and expose the constraints that remain active.

## SwiftUI

```swift
import SwiftUI

struct FilteredSearch: View {
    @State private var query = ""
    @State private var favoritesOnly = false
    private let places = ["Big Sur", "Carmel", "Point Reyes"]
    private let favorites: Set<String> = ["Big Sur"]

    var body: some View {
        NavigationStack {
            List {
                Toggle("Favorites only", isOn: $favoritesOnly)
                ForEach(places.filter {
                    (!favoritesOnly || favorites.contains($0)) &&
                    (query.isEmpty || $0.localizedCaseInsensitiveContains(query))
                }, id: \.self) { Text($0) }
            }
            .searchable(text: $query)
        }
    }
}
```

## Captures

<!-- captures:start -->
<!-- captures:end -->

## Full example

[Open the complete runnable example](SearchFiltersDemo.swift).

## Reference

[Apple: searchable](https://developer.apple.com/documentation/swiftui/view/searchable(text:placement:prompt:)).

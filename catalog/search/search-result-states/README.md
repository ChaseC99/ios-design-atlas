---
id: "search-result-states"
title: "Search result states"
summary: "A search experience distinguishes an empty query, loading, no matches, and a recoverable error."
category: "Search"
family: "Results"
order: 1406
kind: "native"
demoMinIOS: "18.0"
swiftFile: "SearchResultStatesDemo.swift"
view: "SearchResultStatesDemo"
captureNavigation: true
ownsNavigation: false
captureKeyboard: false
apis: ["task(id:)", "ProgressView", "ContentUnavailableView"]
tags: ["empty query", "loading", "no results", "error", "retry", "cancellation"]
---

# Search result states

A search experience distinguishes an empty query, loading, no matches, and a recoverable error.

## SwiftUI

```swift
import SwiftUI

struct EmptySearchResults: View {
    @State private var query = ""
    private var results: [String] {
        ["Big Sur", "Carmel"].filter { query.isEmpty || $0.localizedCaseInsensitiveContains(query) }
    }

    var body: some View {
        NavigationStack {
            List(results, id: \.self) { Text($0) }
                .overlay {
                    if results.isEmpty { ContentUnavailableView.search(text: query) }
                }
                .searchable(text: $query)
        }
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Search result states on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792766578.286.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Search result states on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792766397.18.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](SearchResultStatesDemo.swift).

## Reference

[Apple: task(id:)](https://developer.apple.com/documentation/swiftui/contentunavailableview).

---
id: "split-view-search"
title: "Search in split views"
summary: "A search field can filter the selected sidebar collection while leaving the larger navigation structure intact."
category: "Search"
family: "Navigation"
order: 1409
kind: "native"
demoMinIOS: "18.0"
swiftFile: "SplitViewSearchDemo.swift"
view: "SplitViewSearchDemo"
captureNavigation: false
ownsNavigation: true
captureKeyboard: false
apis: ["NavigationSplitView", "searchable", "List(selection:)"]
tags: ["split view", "sidebar", "iPad", "collection"]
---

# Search in split views

A search field can filter the selected sidebar collection while leaving the larger navigation structure intact.

## SwiftUI

```swift
import SwiftUI

struct SearchableSplitView: View {
    @State private var collection: String? = "Travel"
    @State private var query = ""
    private let notes = ["Travel": ["Northern coast", "City weekends"], "Personal": ["Morning pages"]]

    var body: some View {
        NavigationSplitView {
            List(notes.keys.sorted(), id: \.self, selection: $collection) {
                NavigationLink($0, value: $0)
            }
        } detail: {
            List((notes[collection ?? ""] ?? []).filter {
                query.isEmpty || $0.localizedCaseInsensitiveContains(query)
            }, id: \.self) { Text($0) }
            .searchable(text: $query)
        }
    }
}
```

## Captures

<!-- captures:start -->
<!-- captures:end -->

## Full example

[Open the complete runnable example](SplitViewSearchDemo.swift).

## Reference

[Apple: NavigationSplitView](https://developer.apple.com/documentation/swiftui/navigationsplitview).

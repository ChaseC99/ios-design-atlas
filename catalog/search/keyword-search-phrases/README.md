---
id: "keyword-search-phrases"
title: "Phrase search patterns"
summary: "A small local keyword matcher can turn familiar phrases into explicit search filters."
category: "Search"
family: "Custom search"
order: 1410
kind: "custom"
demoMinIOS: "18.0"
swiftFile: "KeywordSearchPhrasesDemo.swift"
view: "KeywordSearchPhrasesDemo"
captureNavigation: true
ownsNavigation: false
captureKeyboard: false
apis: ["searchable", "searchSuggestions", "searchCompletion"]
tags: ["phrases", "custom search", "keywords", "dictation"]
---

# Phrase search patterns

A small local keyword matcher can turn familiar phrases into explicit search filters.

## SwiftUI

```swift
import SwiftUI

struct LocalPhraseSearch: View {
    @State private var query = ""
    private let places = ["Harbor walk": Set(["quiet", "water"]), "Courtyard café": Set(["coffee", "outdoors"])]
    private var tags: Set<String> {
        Set(["quiet", "water", "coffee", "outdoors"].filter { query.localizedCaseInsensitiveContains($0) })
    }

    var body: some View {
        NavigationStack {
            List(places.keys.sorted().filter {
                query.isEmpty || (!tags.isEmpty && tags.isSubset(of: places[$0] ?? [])) || $0.localizedCaseInsensitiveContains(query)
            }, id: \.self) { Text($0) }
            .searchable(text: $query, prompt: "Try quiet places near water")
        }
    }
}
```

## Captures

<!-- captures:start -->
<!-- captures:end -->

## Full example

[Open the complete runnable example](KeywordSearchPhrasesDemo.swift).

## Reference

[Apple: searchable](https://developer.apple.com/documentation/swiftui/view/searchable(text:placement:prompt:)).

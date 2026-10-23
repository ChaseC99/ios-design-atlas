---
id: "search-tokens"
title: "Search tokens"
summary: "Tokens turn structured constraints into removable items inside the native search field."
category: "Search"
family: "Search fields"
order: 1404
kind: "native"
demoMinIOS: "18.0"
swiftFile: "SearchTokensDemo.swift"
view: "SearchTokensDemo"
captureNavigation: true
ownsNavigation: false
captureKeyboard: true
apis: ["searchable(tokens:)", "searchCompletion", "Identifiable"]
tags: ["tokens", "structured search", "suggested tokens"]
---

# Search tokens

Tokens turn structured constraints into removable items inside the native search field.

## SwiftUI

```swift
import SwiftUI

struct TokenSearch: View {
    struct Token: Identifiable { let id: String }
    @State private var query = ""
    @State private var tokens: [Token] = []
    @State private var suggestions = [Token(id: "Coast"), Token(id: "Quiet")]

    var body: some View {
        NavigationStack {
            Text(tokens.map(\.id).joined(separator: ", "))
                .searchable(text: $query, tokens: $tokens, suggestedTokens: $suggestions) {
                    Text($0.id)
                }
        }
    }
}
```

## Captures

<!-- captures:start -->
<!-- captures:end -->

## Full example

[Open the complete runnable example](SearchTokensDemo.swift).

## Reference

[Apple: searchable(tokens:)](https://developer.apple.com/documentation/swiftui/performing-a-search-operation).

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
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Search state during navigation on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792766566.124.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Search state during navigation on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792766381.996.png)

### iPhone 18 Pro · iOS 27.0

default. light appearance; Large text; en_US.

![Search state during navigation on iPhone 18 Pro, iOS 27.0](captures/ios-27-0-iphone-18-pro-default-1792768505.905.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](SearchNavigationStateDemo.swift).

## Reference

[Apple: NavigationStack](https://developer.apple.com/documentation/swiftui/navigationstack).

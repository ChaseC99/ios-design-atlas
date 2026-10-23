---
id: "search-highlighting-groups"
title: "Highlighted and grouped results"
summary: "Grouping gives results context, while highlighted matches show why each item appeared."
category: "Search"
family: "Results"
order: 1407
kind: "native"
demoMinIOS: "18.0"
swiftFile: "SearchHighlightingGroupsDemo.swift"
view: "SearchHighlightingGroupsDemo"
captureNavigation: true
ownsNavigation: false
captureKeyboard: false
apis: ["AttributedString", "Section", "searchable"]
tags: ["highlight", "groups", "categorized results"]
---

# Highlighted and grouped results

Grouping gives results context, while highlighted matches show why each item appeared.

## SwiftUI

```swift
import SwiftUI

struct HighlightedSearchResult: View {
    let title = "Northern coast"
    let query = "coast"

    var body: some View {
        Text(highlighted)
    }
    private var highlighted: AttributedString {
        var text = AttributedString(title)
        if let range = text.range(of: query, options: .caseInsensitive) {
            text[range].font = .body.bold()
            text[range].foregroundColor = .indigo
        }
        return text
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Highlighted and grouped results on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792766559.996.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Highlighted and grouped results on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792766375.436.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](SearchHighlightingGroupsDemo.swift).

## Reference

[Apple: AttributedString](https://developer.apple.com/documentation/swiftui/text).

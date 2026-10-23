---
id: "expandable-selectable-text"
title: "Expandable and selectable text"
summary: "Offer a short preview and let the reader choose the rest."
category: "Typography"
family: "Reading"
order: 1508
kind: "native"
demoMinIOS: "18.0"
swiftFile: "ExpandableSelectableTextDemo.swift"
view: "ExpandableSelectableTextDemo"
captureNavigation: true
ownsNavigation: false
captureStyle: "screen"
apis: ["lineLimit", "textSelection"]
tags: ["read more", "copy", "selection"]
---

# Expandable and selectable text

An expandable passage can reveal more text on demand, and text selection lets readers copy words from read-only content.

## SwiftUI

```swift
import SwiftUI

struct ReadMore: View {
    @State private var expanded = false
    let passage: String
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(passage).lineLimit(expanded ? nil : 3)
                .textSelection(.enabled)
            Button(expanded ? "Read less" : "Read more") {
                withAnimation { expanded.toggle() }
            }
        }
    }
}
```

## Captures

<!-- captures:start -->
<!-- captures:end -->

## Full example

[Open the complete runnable example](ExpandableSelectableTextDemo.swift).

## Reference

[Apple: lineLimit](https://developer.apple.com/documentation/swiftui/view/textselection(_:)).

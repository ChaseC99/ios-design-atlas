---
id: "empty-and-unavailable"
title: "Empty and unavailable content"
summary: "Make the absence of content useful."
category: "States"
family: "Empty states"
order: 2403
kind: "native"
demoMinIOS: "18.0"
swiftFile: "EmptyUnavailableDemo.swift"
view: "EmptyUnavailableDemo"
apis: ["ContentUnavailableView", "ContentUnavailableView.search"]
tags: ["first-use", "empty-collection", "search", "unavailable", "recovery"]
captureNavigation: true
captureStyle: "screen"
---

# Empty and unavailable content

ContentUnavailableView gives empty collections, first-use screens, missing search results, and unavailable content a consistent native structure. A short explanation and a relevant action should help someone create, find, or restore content instead of leaving a blank screen.

## SwiftUI

```swift
import SwiftUI

struct EmptyStateRecipe: View {
    @State private var places: [String] = []
    var body: some View {
        if places.isEmpty {
            ContentUnavailableView {
                Label("Your places start here", systemImage: "bookmark")
            } description: {
                Text("Keep the places you want to return to.")
            } actions: {
                Button("Add a sample place") { places.append("Harbor walk") }
                    .buttonStyle(.borderedProminent)
            }
        } else {
            List(places, id: \.self) { Text($0) }
        }
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Empty and unavailable content on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792770614.92.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](EmptyUnavailableDemo.swift).

## Reference

[Apple: loading](https://developer.apple.com/design/human-interface-guidelines/loading).

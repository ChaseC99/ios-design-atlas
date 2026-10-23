---
id: "list-styles"
title: "List styles"
summary: "Plain, grouped, and inset-grouped lists organize the same rows in different ways."
category: "Lists"
family: "Structure"
order: 901
kind: "native"
demoMinIOS: "18.0"
swiftFile: "ListStylesDemo.swift"
view: "ListStylesDemo"
captureNavigation: true
ownsNavigation: false
apis: ["List", "listStyle", "Section"]
tags: ["plain", "grouped", "inset grouped", "headers", "footers"]
---

# List styles

Plain, grouped, and inset-grouped lists organize the same rows in different ways.

## SwiftUI

```swift
import SwiftUI

struct GroupedCollections: View {
    var body: some View {
        List {
            Section {
                Label("Morning rituals", systemImage: "sun.horizon")
                Label("Small adventures", systemImage: "leaf")
            } header: {
                Text("Pinned")
            } footer: {
                Text("Your favorites, always close by.")
            }
        }
        .listStyle(.insetGrouped)
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![List styles on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792766090.026.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![List styles on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792765888.714.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](ListStylesDemo.swift).

## Reference

[Apple: List](https://developer.apple.com/documentation/swiftui/list).

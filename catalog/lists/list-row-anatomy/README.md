---
id: "list-row-anatomy"
title: "Row anatomy"
summary: "Rows combine text, symbols, thumbnails, values, and controls within a consistent alignment."
category: "Lists"
family: "Rows"
order: 902
kind: "native"
demoMinIOS: "18.0"
swiftFile: "ListRowAnatomyDemo.swift"
view: "ListRowAnatomyDemo"
captureNavigation: true
ownsNavigation: false
apis: ["LabeledContent", "listRowInsets", "listRowSeparator", "listRowBackground", "listRowSpacing"]
tags: ["multiline", "accessories", "spacing", "insets", "separators"]
---

# Row anatomy

Rows combine text, symbols, thumbnails, values, and controls within a consistent alignment.

## SwiftUI

```swift
import SwiftUI

struct ArticleRow: View {
    var body: some View {
        List {
            HStack(alignment: .top, spacing: 14) {
                Image(systemName: "mountain.2.fill")
                    .frame(width: 52, height: 52)
                    .background(.teal.opacity(0.1), in: .rect(cornerRadius: 12))
                VStack(alignment: .leading, spacing: 4) {
                    Text("The scenic route").font(.headline)
                    Text("Notes from a slower weekend.")
                        .font(.subheadline).foregroundStyle(.secondary)
                }
            }
            .listRowInsets(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
            .listRowSeparator(.hidden)
        }
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Row anatomy on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792766067.433.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Row anatomy on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792765844.219.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](ListRowAnatomyDemo.swift).

## Reference

[Apple: LabeledContent](https://developer.apple.com/documentation/swiftui/list).

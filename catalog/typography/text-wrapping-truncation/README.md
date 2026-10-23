---
id: "text-wrapping-truncation"
title: "Wrapping, truncation, and scaling"
summary: "Choose which constraint a line of text should respect."
category: "Typography"
family: "Layout"
order: 1504
kind: "native"
demoMinIOS: "18.0"
swiftFile: "TextWrappingTruncationDemo.swift"
view: "TextWrappingTruncationDemo"
captureNavigation: true
ownsNavigation: false
captureStyle: "screen"
apis: ["lineLimit", "truncationMode", "minimumScaleFactor", "fixedSize"]
tags: ["wrapping", "truncation", "compression"]
---

# Wrapping, truncation, and scaling

Line limits, truncation, minimum scaling, and fixed sizing produce different results when text has less space than it needs.

## SwiftUI

```swift
import SwiftUI

struct ConstrainedTitle: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Somewhere between the sea and the sky")
                .lineLimit(1).truncationMode(.middle)
            Text("Somewhere between the sea and the sky")
                .lineLimit(1).minimumScaleFactor(0.6)
            Text("Somewhere between the sea and the sky")
                .fixedSize(horizontal: false, vertical: true)
        }.font(.title2).frame(width: 260)
    }
}
```

## Captures

<!-- captures:start -->
<!-- captures:end -->

## Full example

[Open the complete runnable example](TextWrappingTruncationDemo.swift).

## Reference

[Apple: lineLimit](https://developer.apple.com/documentation/swiftui/view/linelimit(_:)).

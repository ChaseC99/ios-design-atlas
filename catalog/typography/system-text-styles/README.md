---
id: "system-text-styles"
title: "System text styles"
summary: "A native type scale that responds to Dynamic Type."
category: "Typography"
family: "Type scale"
order: 1501
kind: "native"
demoMinIOS: "18.0"
swiftFile: "SystemTextStylesDemo.swift"
view: "SystemTextStylesDemo"
captureNavigation: true
ownsNavigation: false
captureStyle: "screen"
apis: ["Font.TextStyle", "font"]
tags: ["dynamic type", "headings", "body"]
---

# System text styles

Semantic text styles express hierarchy and resize with the user’s preferred text size.

## SwiftUI

```swift
import SwiftUI

struct SemanticType: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("A quiet morning").font(.largeTitle)
            Text("A little room to think.").font(.headline)
            Text("Semantic styles adapt to Dynamic Type.").font(.body)
            Text("FIELD NOTES / 01").font(.caption)
                .foregroundStyle(.secondary)
        }.padding()
    }
}
```

## Captures

<!-- captures:start -->
<!-- captures:end -->

## Full example

[Open the complete runnable example](SystemTextStylesDemo.swift).

## Reference

[Apple: Font.TextStyle](https://developer.apple.com/documentation/swiftui/font/textstyle).

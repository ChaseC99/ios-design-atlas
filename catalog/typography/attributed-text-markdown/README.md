---
id: "attributed-text-markdown"
title: "Attributed text and Markdown"
summary: "Emphasis, color, and links inside a single passage."
category: "Typography"
family: "Rich text"
order: 1506
kind: "native"
demoMinIOS: "18.0"
swiftFile: "AttributedTextMarkdownDemo.swift"
view: "AttributedTextMarkdownDemo"
captureNavigation: true
ownsNavigation: false
captureStyle: "screen"
apis: ["AttributedString", "Text"]
tags: ["markdown", "inline links", "emphasis"]
---

# Attributed text and Markdown

Attributed strings and inline Markdown allow one text view to contain emphasis, links, and custom styling.

## SwiftUI

```swift
import SwiftUI

struct InlineMarkdown: View {
    var body: some View {
        Text("**Slow down.** Notice the *small things*. [Learn about SwiftUI](https://developer.apple.com/swiftui/).")
            .font(.title3).lineSpacing(6).tint(.teal)
            .padding()
    }
}
```

## Captures

<!-- captures:start -->
<!-- captures:end -->

## Full example

[Open the complete runnable example](AttributedTextMarkdownDemo.swift).

## Reference

[Apple: AttributedString](https://developer.apple.com/documentation/foundation/attributedstring).

---
id: "rich-text-editing"
title: "Rich text editing"
summary: "An attributed text editor preserves formatting and allows attributes to be applied to the current selection."
category: "Text input"
family: "Editors"
order: 1305
kind: "native"
demoMinIOS: "26.0"
swiftFile: "RichTextEditingDemo.swift"
view: "RichTextEditingDemo"
captureNavigation: true
ownsNavigation: false
captureKeyboard: true
apis: ["TextEditor", "AttributedTextSelection", "transformAttributes"]
tags: ["rich text", "formatting", "selection", "iOS 26"]
---

# Rich text editing

An attributed text editor preserves formatting and allows attributes to be applied to the current selection.

## SwiftUI

```swift
import SwiftUI

@available(iOS 26.0, *)
struct FormattedEditor: View {
    @State private var text = AttributedString("Some words are worth keeping.")
    @State private var selection = AttributedTextSelection()

    var body: some View {
        VStack {
            TextEditor(text: $text, selection: $selection)
            Button("Make selection bold") {
                text.transformAttributes(in: &selection) { attributes in
                    attributes.font = .body.bold()
                }
            }
        }
        .padding()
    }
}
```

## Captures

<!-- captures:start -->
<!-- captures:end -->

## Full example

[Open the complete runnable example](RichTextEditingDemo.swift).

## Reference

[Apple: TextEditor](https://developer.apple.com/documentation/swiftui/attributedtextselection).

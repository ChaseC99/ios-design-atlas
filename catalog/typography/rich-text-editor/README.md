---
id: "rich-text-editor"
title: "Rich-text editing"
summary: "Native attributed-text editing with selection-aware formatting."
category: "Typography"
family: "Rich text"
order: 1509
kind: "native"
demoMinIOS: "26.0"
swiftFile: "RichTextEditorDemo.swift"
view: "RichTextEditorDemo"
captureNavigation: true
ownsNavigation: false
captureStyle: "screen"
apis: ["TextEditor", "AttributedTextSelection", "transformAttributes"]
tags: ["formatting", "selection", "editor"]
---

# Rich-text editing

An attributed-text editor preserves formatting while editing, and selection-aware transformations apply styles to the selected text or insertion point.

## SwiftUI

```swift
import SwiftUI

@available(iOS 26.0, *)
struct FormattedEditor: View {
    @State private var text = AttributedString("A note to remember")
    @State private var selection = AttributedTextSelection()
    var body: some View {
        TextEditor(text: $text, selection: $selection)
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button("Bold", systemImage: "bold") {
                        text.transformAttributes(in: &selection) {
                            $0.font = .body.bold()
                        }
                    }
                }
            }
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Rich-text editing on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792766240.351.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](RichTextEditorDemo.swift).

## Reference

[Apple: TextEditor](https://developer.apple.com/documentation/swiftui/texteditor).

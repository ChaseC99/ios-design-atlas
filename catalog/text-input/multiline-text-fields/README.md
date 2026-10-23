---
id: "multiline-text-fields"
title: "Multiline text fields"
summary: "A vertical-axis text field grows through a range of lines before it begins scrolling."
category: "Text input"
family: "Fields"
order: 1303
kind: "native"
demoMinIOS: "18.0"
swiftFile: "MultilineTextFieldsDemo.swift"
view: "MultilineTextFieldsDemo"
captureNavigation: true
ownsNavigation: false
captureKeyboard: true
apis: ["TextField", "lineLimit", "FocusState"]
tags: ["multiline", "character count", "validation", "composition"]
---

# Multiline text fields

A vertical-axis text field grows through a range of lines before it begins scrolling.

## SwiftUI

```swift
import SwiftUI

struct GrowingNoteField: View {
    @State private var note = ""

    var body: some View {
        VStack(alignment: .trailing) {
            TextField("Write a short note", text: $note, axis: .vertical)
                .lineLimit(3...6)
                .textFieldStyle(.roundedBorder)
            Text("\(note.count)/180").font(.caption)
                .foregroundStyle(note.count > 180 ? .red : .secondary)
            Button("Save") { }
                .disabled(note.isEmpty || note.count > 180)
        }
        .padding()
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Multiline text fields on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792770808.013.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](MultilineTextFieldsDemo.swift).

## Reference

[Apple: TextField](https://developer.apple.com/documentation/swiftui/textfield).

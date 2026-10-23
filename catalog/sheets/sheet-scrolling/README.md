---
id: "sheet-scrolling"
title: "Scrolling and resizing"
summary: "Decide what an upward swipe does first."
category: "Sheets"
family: "Interaction"
order: 106
kind: "native"
demoMinIOS: "18.0"
swiftFile: "SheetScrollingDemo.swift"
view: "SheetScrollingDemo"
apis: ["presentationContentInteraction", "presentationDetents"]
tags: ["scrolling", "resizing", "list", "gestures"]
captureNavigation: false
captureStyle: "screen"
---

# Scrolling and resizing

A sheet containing scrollable content can use a gesture to resize the presentation or move through its content. Presentation content interaction lets you prefer scrolling immediately or expanding the sheet before scrolling.

## SwiftUI

```swift
import SwiftUI

struct SheetScrollingRecipe: View {
    @State private var isPresented = false

    var body: some View {
        Button("Show reading list") { isPresented = true }
            .sheet(isPresented: $isPresented) {
                List(1...30, id: \.self) { Text("Field note \($0)") }
                    .presentationDetents([.medium, .large])
                    .presentationContentInteraction(.scrolls)
            }
    }
}
```

## Captures

<!-- captures:start -->
Captures have not been recorded yet.
<!-- captures:end -->

## Full example

[Open the complete runnable example](SheetScrollingDemo.swift).

## Reference

[Apple: sheets](https://developer.apple.com/design/human-interface-guidelines/sheets).

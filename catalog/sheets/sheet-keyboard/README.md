---
id: "sheet-keyboard"
title: "Keyboards inside sheets"
summary: "Keep an editing task comfortable as the keyboard appears."
category: "Sheets"
family: "Interaction"
order: 108
kind: "native"
demoMinIOS: "18.0"
swiftFile: "SheetKeyboardDemo.swift"
view: "SheetKeyboardDemo"
apis: ["FocusState", "scrollDismissesKeyboard", "toolbar", "presentationDetents"]
tags: ["keyboard", "focus", "text-input", "safe-area"]
captureNavigation: false
captureStyle: "screen"
---

# Keyboards inside sheets

An editing sheet responds to keyboard focus and the space left above the keyboard. Focus state, submit actions, a keyboard toolbar, and interactive keyboard dismissal keep a short form easy to move through.

## SwiftUI

```swift
import SwiftUI

struct SheetKeyboardRecipe: View {
    @State private var isPresented = false
    @State private var title = ""
    @FocusState private var isFocused: Bool

    var body: some View {
        Button("New note") { isPresented = true }
            .sheet(isPresented: $isPresented) {
                Form {
                    TextField("Title", text: $title).focused($isFocused)
                }
                .scrollDismissesKeyboard(.interactively)
                .presentationDetents([.medium, .large])
                .task { isFocused = true }
            }
    }
}
```

## Captures

<!-- captures:start -->
Captures have not been recorded yet.
<!-- captures:end -->

## Full example

[Open the complete runnable example](SheetKeyboardDemo.swift).

## Reference

[Apple: sheets](https://developer.apple.com/design/human-interface-guidelines/sheets).

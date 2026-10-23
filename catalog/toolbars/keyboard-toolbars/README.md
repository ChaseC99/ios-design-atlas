---
id: "keyboard-toolbars"
title: "Keyboard toolbars"
summary: "Move between fields or dismiss the keyboard from its accessory bar."
category: "Toolbars"
family: "Placement"
order: 506
kind: "native"
demoMinIOS: "18.0"
swiftFile: "KeyboardToolbarsDemo.swift"
view: "KeyboardToolbarsDemo"
captureNavigation: true
ownsNavigation: false
captureStyle: "screen"
apis: ["ToolbarItemPlacement.keyboard", "FocusState"]
tags: ["keyboard", "next", "previous", "focus"]
---

# Keyboard toolbars

A keyboard toolbar places editing actions above the software keyboard and can use focus state to move between fields.

## SwiftUI

```swift
import SwiftUI

struct KeyboardActions: View {
    @State private var name = ""
    @FocusState private var focused: Bool
    var body: some View {
        TextField("Name", text: $name).focused($focused)
            .textFieldStyle(.roundedBorder).padding()
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") { focused = false }
                }
            }
    }
}
```

## Captures

<!-- captures:start -->
<!-- captures:end -->

## Full example

[Open the complete runnable example](KeyboardToolbarsDemo.swift).

## Reference

[Apple: ToolbarItemPlacement.keyboard](https://developer.apple.com/documentation/swiftui/toolbaritemplacement/keyboard).

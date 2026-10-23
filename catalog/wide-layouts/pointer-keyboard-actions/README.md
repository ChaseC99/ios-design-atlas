---
id: "pointer-keyboard-actions"
title: "Pointer and keyboard actions"
summary: "Give the same actions touch, hover, and shortcut affordances."
category: "Wide layouts"
family: "Input adaptation"
order: 2303
kind: "native"
demoMinIOS: "18.0"
swiftFile: "PointerKeyboardActionsDemo.swift"
view: "PointerKeyboardActionsDemo"
captureNavigation: true
ownsNavigation: false
captureStyle: "screen"
apis: ["keyboardShortcut", "hoverEffect", "FocusState"]
tags: ["iPad", "hardware keyboard", "pointer"]
---

# Pointer and keyboard actions

Native buttons support touch and hardware-keyboard shortcuts; hover effects add pointer feedback on supported devices without replacing the action.

## SwiftUI

```swift
import SwiftUI

struct ShortcutButton: View {
    @State private var saved = false
    var body: some View {
        Button(saved ? "Saved" : "Save", systemImage: "checkmark") { saved = true }
            .keyboardShortcut("s", modifiers: .command)
            .buttonStyle(.borderedProminent)
            .hoverEffect(.lift)
    }
}
```

## Captures

<!-- captures:start -->
<!-- captures:end -->

## Full example

[Open the complete runnable example](PointerKeyboardActionsDemo.swift).

## Reference

[Apple: keyboardShortcut](https://developer.apple.com/documentation/swiftui/view/keyboardshortcut(_:modifiers:)).

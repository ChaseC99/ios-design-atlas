---
id: "undo-notice"
title: "An undo notice"
summary: "Confirm an action while keeping its reversal close by."
category: "Custom patterns"
family: "Feedback patterns"
order: 3403
kind: "custom"
demoMinIOS: "18.0"
swiftFile: "UndoNoticeDemo.swift"
view: "UndoNoticeDemo"
captureNavigation: true
ownsNavigation: false
captureStyle: "screen"
apis: ["safeAreaInset", "Task", "transition"]
tags: ["custom", "toast", "undo"]
---

# An undo notice

A custom undo notice offers a temporary reversal without blocking the screen. Use an alert when the user must acknowledge a decision before continuing.

## SwiftUI

```swift
import SwiftUI

struct UndoNotice: View {
    @State private var archived = false
    var body: some View {
        VStack {
            if !archived { Button("Archive note") { archived = true } }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .safeAreaInset(edge: .bottom) {
            if archived {
                HStack {
                    Text("Note archived")
                    Spacer()
                    Button("Undo") { archived = false }
                }.padding().background(.regularMaterial, in: .rect(cornerRadius: 20)).padding()
            }
        }
    }
}
```

## Captures

<!-- captures:start -->
<!-- captures:end -->

## Full example

[Open the complete runnable example](UndoNoticeDemo.swift).

## Reference

[Apple documentation](https://developer.apple.com/documentation/swiftui/view/safeareainset(edge:alignment:spacing:content:)).

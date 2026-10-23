---
id: "keyboard-safe-area"
title: "Keyboard-safe composers"
summary: "A bottom safe-area inset keeps a composer above the keyboard while the conversation scrolls independently."
category: "Text input"
family: "Keyboards"
order: 1309
kind: "native"
demoMinIOS: "18.0"
swiftFile: "KeyboardSafeAreaDemo.swift"
view: "KeyboardSafeAreaDemo"
captureNavigation: true
ownsNavigation: false
captureKeyboard: true
apis: ["safeAreaInset", "scrollDismissesKeyboard", "FocusState"]
tags: ["keyboard avoidance", "chat", "composer", "hardware keyboard"]
---

# Keyboard-safe composers

A bottom safe-area inset keeps a composer above the keyboard while the conversation scrolls independently.

## SwiftUI

```swift
import SwiftUI

struct KeyboardAwareComposer: View {
    @State private var draft = ""

    var body: some View {
        ScrollView {
            Text("A conversation lives here.").padding()
        }
        .scrollDismissesKeyboard(.interactively)
        .safeAreaInset(edge: .bottom) {
            TextField("Message", text: $draft, axis: .vertical)
                .lineLimit(1...4)
                .textFieldStyle(.roundedBorder)
                .padding()
                .background(.bar)
        }
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Keyboard-safe composers on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792770714.009.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](KeyboardSafeAreaDemo.swift).

## Reference

[Apple: safeAreaInset](https://developer.apple.com/documentation/swiftui/view/safeareainset(edge:alignment:spacing:content:)).

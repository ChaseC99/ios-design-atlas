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
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Keyboard toolbars on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792766011.145.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Keyboard toolbars on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792765763.523.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](KeyboardToolbarsDemo.swift).

## Reference

[Apple: ToolbarItemPlacement.keyboard](https://developer.apple.com/documentation/swiftui/toolbaritemplacement/keyboard).

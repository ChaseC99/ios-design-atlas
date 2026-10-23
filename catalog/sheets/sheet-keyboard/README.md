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
captureKeyboard: true
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
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Keyboards inside sheets on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792764313.921.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Keyboards inside sheets on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792763845.68.png)

### iPhone 18 Pro · iOS 27.0

default. light appearance; Large text; en_US.

![Keyboards inside sheets on iPhone 18 Pro, iOS 27.0](captures/ios-27-0-iphone-18-pro-default-1792764125.389.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](SheetKeyboardDemo.swift).

## Reference

[Apple: sheets](https://developer.apple.com/design/human-interface-guidelines/sheets).

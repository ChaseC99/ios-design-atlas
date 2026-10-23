---
id: "keyboard-safe-areas"
title: "Keyboard safe areas"
summary: "A composer follows the keyboard while its background stays full bleed."
category: "Scroll edges"
family: "Safe areas"
order: 707
kind: "native"
demoMinIOS: "18.0"
swiftFile: "KeyboardSafeAreasDemo.swift"
view: "KeyboardSafeAreasDemo"
captureNavigation: true
captureStyle: "screen"
captureKeyboard: true
apis: ["safeAreaInset", "scrollDismissesKeyboard", "ignoresSafeArea"]
tags: ["keyboard", "composer", "focus"]
---

# Keyboard safe areas

A bottom inset lets a composer move with the keyboard, while ignoring safe areas only on its background preserves keyboard avoidance.

## SwiftUI

```swift
import SwiftUI

struct KeyboardComposer: View {
    @State private var message = ""
    var body: some View {
        ScrollView { Text("Conversation").padding() }
            .scrollDismissesKeyboard(.interactively)
            .safeAreaInset(edge: .bottom) {
                TextField("Message", text: $message, axis: .vertical)
                    .lineLimit(1...4).textFieldStyle(.roundedBorder)
                    .padding().background(.bar)
            }
            .background {
                Color(uiColor: .systemGroupedBackground)
                    .ignoresSafeArea()
            }
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Keyboard safe areas on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792765979.704.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Keyboard safe areas on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792765756.902.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](KeyboardSafeAreasDemo.swift).

## Reference

[Apple: safeAreaInset](https://developer.apple.com/documentation/swiftui/view/safeareainset(edge:alignment:spacing:content:)).

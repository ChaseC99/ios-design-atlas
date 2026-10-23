---
id: "formatted-text-input"
title: "Formatted values and keyboard types"
summary: "Value formatting and content types help the keyboard match the kind of information a field expects."
category: "Text input"
family: "Keyboards"
order: 1307
kind: "native"
demoMinIOS: "18.0"
swiftFile: "FormattedTextInputDemo.swift"
view: "FormattedTextInputDemo"
captureNavigation: true
ownsNavigation: false
captureKeyboard: true
apis: ["TextField(value:format:)", "keyboardType", "textContentType"]
tags: ["number", "currency", "phone", "one-time code", "autofill"]
---

# Formatted values and keyboard types

Value formatting and content types help the keyboard match the kind of information a field expects.

## SwiftUI

```swift
import SwiftUI

struct FormattedAmount: View {
    @State private var amount = 24.50
    @State private var code = ""

    var body: some View {
        Form {
            TextField("Amount", value: $amount, format: .currency(code: "USD"))
                .keyboardType(.decimalPad)
            TextField("One-time code", text: $code)
                .keyboardType(.numberPad)
                .textContentType(.oneTimeCode)
        }
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Formatted values and keyboard types on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792765646.669.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Formatted values and keyboard types on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792765563.879.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](FormattedTextInputDemo.swift).

## Reference

[Apple: TextField(value:format:)](https://developer.apple.com/documentation/swiftui/textfield).

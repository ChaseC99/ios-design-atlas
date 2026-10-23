---
id: "button-states"
title: "Button states and roles"
summary: "Show progress, availability, and consequences."
category: "Buttons"
family: "Buttons"
order: 1103
kind: "native"
demoMinIOS: "18.0"
swiftFile: "ButtonStatesDemo.swift"
view: "ButtonStatesDemo"
apis: ["ButtonRole", "disabled", "ProgressView", "Toggle"]
tags: ["loading", "disabled", "success", "destructive", "selection"]
captureNavigation: true
captureStyle: "screen"
---

# Button states and roles

A button can communicate progress and success while roles distinguish ordinary, destructive, and cancellation actions. Disable unavailable operations and keep the label stable enough that a state change does not disrupt the layout.

## SwiftUI

```swift
import SwiftUI

struct ButtonStatesRecipe: View {
    @State private var isSaving = false
    @State private var saved = false
    var body: some View {
        Button {
            isSaving = true
            Task {
                try? await Task.sleep(for: .seconds(1))
                saved = true
                isSaving = false
            }
        } label: {
            HStack {
                if isSaving { ProgressView() }
                Text(isSaving ? "Saving…" : saved ? "Saved" : "Save")
            }
        }
        .buttonStyle(.borderedProminent)
        .disabled(isSaving)
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Button states and roles on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792765474.068.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Button states and roles on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792765378.949.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](ButtonStatesDemo.swift).

## Reference

[Apple: buttons](https://developer.apple.com/design/human-interface-guidelines/buttons).

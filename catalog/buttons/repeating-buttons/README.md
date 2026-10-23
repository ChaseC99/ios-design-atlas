---
id: "repeating-buttons"
title: "Repeating buttons"
summary: "Let a held action continue at the system’s pace."
category: "Buttons"
family: "Buttons"
order: 1104
kind: "native"
demoMinIOS: "18.0"
swiftFile: "RepeatingButtonsDemo.swift"
view: "RepeatingButtonsDemo"
apis: ["buttonRepeatBehavior", "disabled", "monospacedDigit"]
tags: ["repeat", "press-and-hold", "increment"]
captureNavigation: true
captureStyle: "screen"
---

# Repeating buttons

A repeating button performs its action while it remains pressed. This is useful for small bounded adjustments, with disabled states at the limits and an accessible value that explains the current setting.

## SwiftUI

```swift
import SwiftUI

struct RepeatingButtonRecipe: View {
    @State private var servings = 2
    var body: some View {
        HStack {
            Text("Servings: \(servings)").monospacedDigit()
            Button("Add serving", systemImage: "plus") { servings += 1 }
                .buttonRepeatBehavior(.enabled)
                .disabled(servings >= 12)
        }
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Repeating buttons on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792766494.296.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Repeating buttons on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792766216.608.png)

### iPhone 18 Pro · iOS 27.0

default. light appearance; Large text; en_US.

![Repeating buttons on iPhone 18 Pro, iOS 27.0](captures/ios-27-0-iphone-18-pro-default-1792768367.784.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](RepeatingButtonsDemo.swift).

## Reference

[Apple: buttons](https://developer.apple.com/design/human-interface-guidelines/buttons).

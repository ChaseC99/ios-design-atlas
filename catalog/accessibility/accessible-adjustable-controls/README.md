---
id: "accessible-adjustable-controls"
title: "Adjustable controls"
summary: "An adjustable accessibility action gives a custom visual control an increment-and-decrement interface."
category: "Accessibility"
family: "Semantics"
order: 2004
kind: "custom"
demoMinIOS: "18.0"
swiftFile: "AccessibleAdjustableControlsDemo.swift"
view: "AccessibleAdjustableControlsDemo"
captureNavigation: true
ownsNavigation: false
captureEnvironmentNotes: "The default capture uses the system Large text setting. Preview controls affect only this example."
apis: ["accessibilityAdjustableAction", "accessibilityValue", "accessibilityElement"]
tags: ["rating", "adjustable", "custom control", "VoiceOver"]
---

# Adjustable controls

An adjustable accessibility action gives a custom visual control an increment-and-decrement interface.

## SwiftUI

```swift
import SwiftUI

struct AdjustableRating: View {
    @State private var rating = 3

    var body: some View {
        HStack {
            ForEach(1...5, id: \.self) { value in
                Image(systemName: value <= rating ? "star.fill" : "star")
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Rating")
        .accessibilityValue("\(rating) of 5 stars")
        .accessibilityAdjustableAction {
            switch $0 {
            case .increment: rating = min(5, rating + 1)
            case .decrement: rating = max(1, rating - 1)
            @unknown default: break
            }
        }
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Adjustable controls on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792765309.743.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Adjustable controls on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792765261.103.png)
<!-- captures:end -->

## Verification

The default capture uses the system Large text setting. Preview controls affect only this example. No global accessibility settings are changed. Manual VoiceOver traversal, Voice Control, Switch Control, and hardware-keyboard checks remain pending; screenshots do not verify assistive-technology behavior.

## Full example

[Open the complete runnable example](AccessibleAdjustableControlsDemo.swift).

## Reference

[Apple: accessibilityAdjustableAction](https://developer.apple.com/documentation/swiftui/view/accessibilityadjustableaction(_:)).

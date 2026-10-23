---
id: "sensory-feedback"
title: "Haptics and visible feedback"
summary: "Pair a sensory cue with a readable result."
category: "Gestures"
family: "Feedback"
order: 1908
kind: "native"
demoMinIOS: "18.0"
swiftFile: "SensoryFeedbackDemo.swift"
view: "SensoryFeedbackDemo"
apis: ["sensoryFeedback", "SensoryFeedback", "UIAccessibility.post"]
tags: ["haptics", "selection", "impact", "success", "warning", "error", "voiceover"]
captureNavigation: true
captureStyle: "screen"
---

# Haptics and visible feedback

Sensory feedback can mark a selection, impact, success, warning, or error. Pair each requested haptic with a visible status and an optional VoiceOver announcement so the result does not depend on hardware, sound, or touch; simulators and still captures cannot demonstrate the haptic itself.

## SwiftUI

```swift
import SwiftUI

struct SensoryFeedbackRecipe: View {
    @State private var saves = 0
    var body: some View {
        VStack(spacing: 20) {
            Label(saves == 0 ? "Ready to save" : "Saved", systemImage: saves == 0 ? "bookmark" : "checkmark.circle.fill")
            Button("Save sample") { saves += 1 }
        }
        .sensoryFeedback(.success, trigger: saves)
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Haptics and visible feedback on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792771014.402.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](SensoryFeedbackDemo.swift).

## Reference

[Apple: gestures](https://developer.apple.com/design/human-interface-guidelines/gestures).

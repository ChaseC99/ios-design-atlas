---
id: "reduced-motion-adaptation"
title: "Reduced motion"
summary: "Motion-sensitive interfaces can replace spatial transitions with a simpler, immediate state change."
category: "Accessibility"
family: "Adaptation"
order: 2007
kind: "native"
demoMinIOS: "18.0"
swiftFile: "ReducedMotionAdaptationDemo.swift"
view: "ReducedMotionAdaptationDemo"
captureNavigation: true
ownsNavigation: false
captureEnvironmentNotes: "The default capture is a settled state. Reduced Motion is read from the environment; the preview switch changes only this example. A static capture cannot verify the transition."
apis: ["accessibilityReduceMotion", "withAnimation", "transition"]
tags: ["reduced motion", "animation", "feedback"]
---

# Reduced motion

Motion-sensitive interfaces can replace spatial transitions with a simpler, immediate state change.

## SwiftUI

```swift
import SwiftUI

struct MotionAwareDisclosure: View {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var expanded = false

    var body: some View {
        VStack {
            Button("Details") {
                withAnimation(reduceMotion ? nil : .spring) { expanded.toggle() }
            }
            if expanded {
                Text("A little more context.")
                    .transition(reduceMotion ? .identity : .move(edge: .top).combined(with: .opacity))
            }
        }
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Reduced motion on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792766455.491.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Reduced motion on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792766197.453.png)
<!-- captures:end -->

## Verification

The default capture is a settled state. Reduced Motion is read from the environment; the preview switch changes only this example. A static capture cannot verify the transition. No global accessibility settings are changed. Manual VoiceOver traversal, Voice Control, Switch Control, and hardware-keyboard checks remain pending; screenshots do not verify assistive-technology behavior.

## Full example

[Open the complete runnable example](ReducedMotionAdaptationDemo.swift).

## Reference

[Apple: accessibilityReduceMotion](https://developer.apple.com/documentation/swiftui/environmentvalues/accessibilityreducemotion).

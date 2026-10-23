---
id: "gesture-driven-motion"
title: "Gesture-driven motion"
summary: "Follow the hand, then settle into place."
category: "Animation"
family: "Interaction"
order: 1806
kind: "custom"
demoMinIOS: "18.0"
swiftFile: "GestureDrivenMotionDemo.swift"
view: "GestureDrivenMotionDemo"
apis: ["DragGesture", "offset", "rotationEffect", "spring"]
tags: ["drag", "direct-manipulation", "spring", "reduce-motion"]
captureNavigation: true
captureStyle: "screen"
---

# Gesture-driven motion

A drag can update position directly while a release animates the content back to rest. Keep the drag bounds clear and remove decorative rotation and spring movement for reduced motion; the capture shows the centered resting card.

## SwiftUI

```swift
import SwiftUI

struct DragMotionRecipe: View {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var offset = CGSize.zero
    var body: some View {
        RoundedRectangle(cornerRadius: 24).fill(.teal).frame(width: 160, height: 120)
            .offset(offset)
            .gesture(DragGesture()
                .onChanged { offset = $0.translation }
                .onEnded { _ in
                    withAnimation(reduceMotion ? nil : .spring(duration: 0.5)) { offset = .zero }
                })
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Gesture-driven motion on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792765868.249.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Gesture-driven motion on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792765584.362.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](GestureDrivenMotionDemo.swift).

## Reference

[Apple: motion](https://developer.apple.com/design/human-interface-guidelines/motion).

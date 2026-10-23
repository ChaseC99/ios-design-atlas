---
id: "phase-and-keyframe-animation"
title: "Phase and keyframe animation"
summary: "Build a small sequence from intentional beats."
category: "Animation"
family: "Sequences"
order: 1805
kind: "native"
demoMinIOS: "18.0"
swiftFile: "PhaseKeyframeDemo.swift"
view: "PhaseKeyframeDemo"
apis: ["phaseAnimator", "KeyframeAnimator", "KeyframeTrack", "SpringKeyframe"]
tags: ["phases", "keyframes", "sequence", "reduce-motion"]
captureNavigation: true
captureStyle: "screen"
---

# Phase and keyframe animation

A phase animator moves through a set of states, while keyframe tracks describe independent changes over time. Triggered sequences return to a predictable resting pose here, and reduced motion leaves the symbols still; a screenshot does not demonstrate the sequence.

## SwiftUI

```swift
import SwiftUI

struct PhaseAnimationRecipe: View {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var trigger = 0
    var body: some View {
        VStack(spacing: 32) {
            Image(systemName: "leaf.fill").font(.system(size: 64)).foregroundStyle(.green)
                .phaseAnimator([false, true], trigger: trigger) { content, raised in
                    content.scaleEffect(raised && !reduceMotion ? 1.2 : 1)
                }
            Button("Play sequence") { trigger += 1 }
        }
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Phase and keyframe animation on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792766322.953.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Phase and keyframe animation on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792766132.398.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](PhaseKeyframeDemo.swift).

## Reference

[Apple: motion](https://developer.apple.com/design/human-interface-guidelines/motion).

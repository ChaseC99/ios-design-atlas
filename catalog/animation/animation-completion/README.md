---
id: "animation-completion"
title: "Completion and result states"
summary: "Finish an animation before announcing the next step."
category: "Animation"
family: "Sequences"
order: 1807
kind: "native"
demoMinIOS: "18.0"
swiftFile: "AnimationCompletionDemo.swift"
view: "AnimationCompletionDemo"
apis: ["withAnimation", "AnimationCompletionCriteria", "ProgressView", "Task"]
tags: ["completion", "loading", "success", "error", "cancellation", "reduce-motion"]
captureNavigation: true
captureStyle: "screen"
---

# Completion and result states

An animation completion callback can coordinate the next visual or status update after a state change finishes. This local simulation moves from ready to working and then success or error, with cancellation and reduced-motion handling; the capture records its ready state.

## SwiftUI

```swift
import SwiftUI

struct AnimationCompletionRecipe: View {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var expanded = false
    @State private var status = "Ready"
    var body: some View {
        VStack(spacing: 24) {
            RoundedRectangle(cornerRadius: 20).fill(.teal)
                .frame(width: expanded ? 220 : 100, height: 100)
            Text(status)
            Button("Animate") {
                status = "Moving"
                withAnimation(reduceMotion ? nil : .smooth, completionCriteria: .logicallyComplete) {
                    expanded.toggle()
                } completion: {
                    status = "Finished"
                }
            }
        }
    }
}
```

## Captures

<!-- captures:start -->
Captures have not been recorded yet.
<!-- captures:end -->

## Full example

[Open the complete runnable example](AnimationCompletionDemo.swift).

## Reference

[Apple: motion](https://developer.apple.com/design/human-interface-guidelines/motion).

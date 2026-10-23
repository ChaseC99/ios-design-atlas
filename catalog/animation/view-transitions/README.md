---
id: "view-transitions"
title: "Insertion and removal transitions"
summary: "Explain how content enters and leaves."
category: "Animation"
family: "Transitions"
order: 1802
kind: "native"
demoMinIOS: "18.0"
swiftFile: "ViewTransitionsDemo.swift"
view: "ViewTransitionsDemo"
apis: ["transition", "AnyTransition", "asymmetric", "withAnimation"]
tags: ["insertion", "removal", "opacity", "scale", "reduce-motion"]
captureNavigation: true
captureStyle: "screen"
---

# Insertion and removal transitions

A transition defines how conditional content enters or leaves a view hierarchy. Asymmetric transitions give insertion and removal different treatments, with an opacity-only alternative for reduced motion; screenshots show the visible endpoint rather than the movement.

## SwiftUI

```swift
import SwiftUI

struct ViewTransitionRecipe: View {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var visible = true
    var body: some View {
        VStack(spacing: 24) {
            if visible {
                Text("Saved for later").padding(24)
                    .background(.teal.opacity(0.12), in: RoundedRectangle(cornerRadius: 20))
                    .transition(reduceMotion ? .opacity : .move(edge: .bottom).combined(with: .opacity))
            }
            Button("Toggle card") {
                withAnimation(.easeInOut(duration: 0.3)) { visible.toggle() }
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

[Open the complete runnable example](ViewTransitionsDemo.swift).

## Reference

[Apple: motion](https://developer.apple.com/design/human-interface-guidelines/motion).

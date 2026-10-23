---
id: "content-and-symbol-transitions"
title: "Text and symbol changes"
summary: "Preserve continuity when a value or icon changes."
category: "Animation"
family: "Content changes"
order: 1804
kind: "native"
demoMinIOS: "18.0"
swiftFile: "ContentSymbolTransitionsDemo.swift"
view: "ContentSymbolTransitionsDemo"
apis: ["contentTransition", "numericText", "symbolEffect", "replace"]
tags: ["numbers", "text", "symbols", "bounce", "reduce-motion"]
captureNavigation: true
captureStyle: "screen"
---

# Text and symbol changes

Content transitions animate changes within a persistent text or image view. Numeric transitions and symbol replacement keep small updates connected to their previous state, while symbol effects can acknowledge an action; captures show only the current values and symbols.

## SwiftUI

```swift
import SwiftUI

struct NumericTransitionRecipe: View {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var count = 12
    var body: some View {
        VStack(spacing: 24) {
            Text(count, format: .number).font(.largeTitle).monospacedDigit()
                .contentTransition(.numericText(value: Double(count)))
            Button("Add one") {
                withAnimation(reduceMotion ? nil : .snappy) { count += 1 }
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

[Open the complete runnable example](ContentSymbolTransitionsDemo.swift).

## Reference

[Apple: motion](https://developer.apple.com/design/human-interface-guidelines/motion).

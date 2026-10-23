---
id: "variable-symbols-effects"
title: "Variable symbols and effects"
summary: "Show progress, feedback, and state changes with native symbols."
category: "Visuals"
family: "Symbols"
order: 1603
kind: "native"
demoMinIOS: "18.0"
swiftFile: "VariableSymbolsEffectsDemo.swift"
view: "VariableSymbolsEffectsDemo"
captureNavigation: true
ownsNavigation: false
captureStyle: "screen"
apis: ["Image.init(systemName:variableValue:)", "symbolEffect", "contentTransition"]
tags: ["variable color", "bounce", "replacement", "reduce motion"]
---

# Variable symbols and effects

Variable symbols can show changing values, and symbol effects add native motion when an action or state changes.

## SwiftUI

```swift
import SwiftUI

struct SymbolFeedback: View {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var count = 0
    var body: some View {
        Button { count += 1 } label: {
            Image(systemName: "bell.fill")
                .font(.largeTitle).symbolEffect(.bounce, value: count)
        }
        .accessibilityLabel("Ring bell")
        .symbolEffectsRemoved(reduceMotion)
    }
}
```

## Captures

<!-- captures:start -->
<!-- captures:end -->

## Full example

[Open the complete runnable example](VariableSymbolsEffectsDemo.swift).

## Reference

[Apple: Image.init(systemName:variableValue:)](https://developer.apple.com/documentation/swiftui/view/symboleffect(_:options:value:)).

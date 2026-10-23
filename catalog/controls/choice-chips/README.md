---
id: "choice-chips"
title: "Single and multiple choices"
summary: "Build compact selections with clear semantics."
category: "Controls"
family: "Custom controls"
order: 1207
kind: "custom"
demoMinIOS: "18.0"
swiftFile: "ChoiceChipsDemo.swift"
view: "ChoiceChipsDemo"
apis: ["Button", "LazyVGrid", "accessibilityAddTraits"]
tags: ["custom", "chips", "single-selection", "multiple-selection", "long-labels"]
captureNavigation: true
captureStyle: "screen"
---

# Single and multiple choices

Custom choice chips use real buttons to select one option or a set of options. A visible selected treatment and accessibility selected traits keep the control understandable beyond color alone, while adaptive layout gives longer labels room to wrap.

## SwiftUI

```swift
import SwiftUI

struct ChoiceChipsRecipe: View {
    @State private var selected: Set<String> = ["Coast"]
    var body: some View {
        HStack {
            ForEach(["Coast", "Forest", "City"], id: \.self) { option in
                Button {
                    if selected.contains(option) { selected.remove(option) }
                    else { selected.insert(option) }
                } label: {
                    Label(option, systemImage: selected.contains(option) ? "checkmark.circle.fill" : "circle")
                }
                .buttonStyle(.bordered)
                .accessibilityAddTraits(selected.contains(option) ? .isSelected : [])
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

[Open the complete runnable example](ChoiceChipsDemo.swift).

## Reference

[Apple: pickers](https://developer.apple.com/design/human-interface-guidelines/pickers).

---
id: "stack-alignment"
title: "Stack spacing and alignment"
summary: "Give related content a common edge or baseline."
category: "Layout"
family: "Stacks"
order: 1701
kind: "custom"
demoMinIOS: "18.0"
swiftFile: "StackAlignmentDemo.swift"
view: "StackAlignmentDemo"
apis: ["HStack", "VStack", "alignmentGuide", "AlignmentID"]
tags: ["spacing", "baseline", "custom-alignment"]
captureNavigation: true
captureStyle: "screen"
---

# Stack spacing and alignment

Stacks arrange content along one axis while alignment guides position it along the other. Text baselines keep mixed type sizes coherent, and a custom guide can align related values across separate rows.

## SwiftUI

```swift
import SwiftUI

struct BaselineRecipe: View {

    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 8) {
            Text("4.8").font(.system(size: 52, weight: .semibold))
            Text("km").font(.title3).foregroundStyle(.secondary)
        }
    }
}
```

## Captures

<!-- captures:start -->
Captures have not been recorded yet.
<!-- captures:end -->

## Full example

[Open the complete runnable example](StackAlignmentDemo.swift).

## Reference

[Apple: layout](https://developer.apple.com/design/human-interface-guidelines/layout).

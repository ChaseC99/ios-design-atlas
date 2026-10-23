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
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Stack spacing and alignment on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792766836.548.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Stack spacing and alignment on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792766537.259.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](StackAlignmentDemo.swift).

## Reference

[Apple: layout](https://developer.apple.com/design/human-interface-guidelines/layout).

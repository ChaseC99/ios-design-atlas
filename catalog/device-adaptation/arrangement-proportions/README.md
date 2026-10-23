---
id: "arrangement-proportions"
title: "Arrangement proportions"
summary: "Give primary content a preferred share of an adaptive split."
category: "Device adaptation"
family: "iPhone Duo"
order: 2203
kind: "native"
demoMinIOS: "27.1"
swiftFile: "ArrangementProportionsDemo.swift"
view: "ArrangementProportionsDemo"
captureNavigation: true
ownsNavigation: false
captureStyle: "screen"
apis: ["splitArrangementLayoutRatio", "splitArrangementLayoutSize"]
tags: ["ratio", "size constraints", "adaptation"]
---

# Arrangement proportions

Arrangement sizing preferences influence the relative space given to each region while allowing the system to respond to layout constraints.

These iOS 27.1 APIs are marked beta in Apple’s documentation and require iOS 27.1.

## SwiftUI

```swift
import SwiftUI

@available(iOS 27.1, *)
struct WeightedArrangement: View {
    var body: some View {
        ArrangementView {
            Text("Article").frame(maxWidth: .infinity, maxHeight: .infinity)
                .splitArrangementLayoutRatio(1.5)
        } secondary: {
            Text("Contents").frame(maxWidth: .infinity, maxHeight: .infinity)
                .splitArrangementLayoutSize(minWidth: 220, idealWidth: 280)
        }
        .arrangementViewStyle(.split)
    }
}
```

## Captures

<!-- captures:start -->
<!-- captures:end -->

## Full example

[Open the complete runnable example](ArrangementProportionsDemo.swift).

## Reference

[Apple: splitArrangementLayoutRatio](https://developer.apple.com/documentation/swiftui/view/splitarrangementlayoutratio(_:)).

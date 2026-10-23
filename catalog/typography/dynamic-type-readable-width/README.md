---
id: "dynamic-type-readable-width"
title: "Dynamic Type and readable width"
summary: "Scale the type and its surrounding space together."
category: "Typography"
family: "Adaptation"
order: 1503
kind: "native"
demoMinIOS: "18.0"
swiftFile: "DynamicTypeReadableWidthDemo.swift"
view: "DynamicTypeReadableWidthDemo"
captureNavigation: true
ownsNavigation: false
captureStyle: "screen"
apis: ["ScaledMetric", "dynamicTypeSize", "Font.custom"]
tags: ["accessibility", "readable width", "custom font"]
---

# Dynamic Type and readable width

Dynamic Type can scale a custom font and nearby layout dimensions, while a maximum content width keeps long lines readable on wider windows.

## SwiftUI

```swift
import SwiftUI

struct ScaledReadingText: View {
    @ScaledMetric(relativeTo: .body) private var spacing = 20.0
    var body: some View {
        VStack(alignment: .leading, spacing: spacing) {
            Text("The time it takes.").font(.largeTitle)
            Text("Some things are better without a deadline.")
                .font(.custom("Georgia", size: 21, relativeTo: .body))
        }
        .frame(maxWidth: 600, alignment: .leading)
        .padding(24).frame(maxWidth: .infinity)
    }
}
```

## Captures

<!-- captures:start -->
<!-- captures:end -->

## Full example

[Open the complete runnable example](DynamicTypeReadableWidthDemo.swift).

## Reference

[Apple: ScaledMetric](https://developer.apple.com/documentation/swiftui/scaledmetric).

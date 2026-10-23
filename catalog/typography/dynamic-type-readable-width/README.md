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
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Dynamic Type and readable width on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792765604.12.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Dynamic Type and readable width on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792765533.967.png)

### iPhone 18 Pro · iOS 27.0

default. light appearance; Large text; en_US.

![Dynamic Type and readable width on iPhone 18 Pro, iOS 27.0](captures/ios-27-0-iphone-18-pro-default-1792767771.589.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](DynamicTypeReadableWidthDemo.swift).

## Reference

[Apple: ScaledMetric](https://developer.apple.com/documentation/swiftui/scaledmetric).

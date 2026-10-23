---
id: "size-class-and-geometry"
title: "Size class and actual geometry"
summary: "Describe the space a view has, without guessing the device."
category: "Device adaptation"
family: "Adaptive foundations"
order: 2206
kind: "native"
demoMinIOS: "18.0"
swiftFile: "SizeClassGeometryDemo.swift"
view: "SizeClassGeometryDemo"
captureNavigation: true
ownsNavigation: false
captureStyle: "screen"
apis: ["GeometryReader", "horizontalSizeClass", "verticalSizeClass"]
tags: ["window size", "size classes", "resizing"]
---

# Size class and actual geometry

Available geometry and size classes describe a view’s environment; neither should be treated as a device-name check.

## SwiftUI

```swift
import SwiftUI

struct AvailableWidth: View {
    @Environment(\.horizontalSizeClass) private var sizeClass
    var body: some View {
        GeometryReader { proxy in
            VStack {
                Text("\(Int(proxy.size.width)) points wide")
                Text(sizeClass == .regular ? "Regular width class" : "Compact or unspecified")
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
```

## Captures

<!-- captures:start -->
<!-- captures:end -->

## Full example

[Open the complete runnable example](SizeClassGeometryDemo.swift).

## Reference

[Apple: GeometryReader](https://developer.apple.com/documentation/swiftui/geometryreader).

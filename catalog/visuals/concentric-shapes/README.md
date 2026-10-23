---
id: "concentric-shapes"
title: "Concentric shapes and elevation"
summary: "Coordinate nested corners, borders, and shadows."
category: "Visuals"
family: "Shapes"
order: 1607
kind: "native"
demoMinIOS: "26.0"
swiftFile: "ConcentricShapesDemo.swift"
view: "ConcentricShapesDemo"
captureNavigation: true
ownsNavigation: false
captureStyle: "screen"
apis: ["ConcentricRectangle", "containerShape", "strokeBorder"]
tags: ["corners", "border", "shadow", "capsule"]
---

# Concentric shapes and elevation

A concentric rectangle derives its corner shape from its container, helping nested surfaces keep a consistent inset relationship.

## SwiftUI

```swift
import SwiftUI

@available(iOS 26.0, *)
struct NestedCorners: View {
    var body: some View {
        Rectangle().fill(.teal.gradient)
            .frame(height: 240)
            .clipShape(ConcentricRectangle())
            .padding(16)
            .background(.background, in: RoundedRectangle(cornerRadius: 40))
            .containerShape(RoundedRectangle(cornerRadius: 40))
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Concentric shapes and elevation on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792765417.736.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](ConcentricShapesDemo.swift).

## Reference

[Apple: ConcentricRectangle](https://developer.apple.com/documentation/swiftui/concentricrectangle).

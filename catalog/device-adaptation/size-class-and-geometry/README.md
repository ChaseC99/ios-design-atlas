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
### iPhone Duo · iOS 27.1

default. light appearance; Large text; en_US.

![Size class and actual geometry on iPhone Duo, iOS 27.1](captures/ios-27-1-atlas-iphone-duo-default-1792765972.819.png)

### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Size class and actual geometry on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792766807.959.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Size class and actual geometry on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792766499.902.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](SizeClassGeometryDemo.swift).

## Reference

[Apple: GeometryReader](https://developer.apple.com/documentation/swiftui/geometryreader).

---
id: "material-versus-opacity"
title: "Material and opacity"
summary: "Compare a translucent fill with a blurred material."
category: "Materials"
family: "Materials"
order: 802
kind: "native"
demoMinIOS: "18.0"
swiftFile: "MaterialVersusOpacityDemo.swift"
view: "MaterialVersusOpacityDemo"
captureNavigation: true
captureStyle: "screen"
apis: ["Material", "opacity"]
tags: ["layering", "overlap", "blur"]
---

# Material and opacity

A translucent color lets the background show through directly; a material also changes the background’s detail and contrast.

## SwiftUI

```swift
import SwiftUI

struct TwoSurfaces: View {
    var body: some View {
        ZStack {
            LinearGradient(colors: [.orange, .indigo],
                           startPoint: .top, endPoint: .bottom)
            VStack(spacing: 24) {
                Text("Translucent color").padding(24)
                    .background(.white.opacity(0.65), in: Capsule())
                Text("Regular material").padding(24)
                    .background(.regularMaterial, in: Capsule())
            }
        }
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 18 Pro · iOS 27.0

default. light appearance; Large text; en_US.

![Material and opacity on iPhone 18 Pro, iOS 27.0](captures/ios-27-0-iphone-18-pro-default-1792762765.179.png)

### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Material and opacity on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792766149.865.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Material and opacity on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792765954.425.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](MaterialVersusOpacityDemo.swift).

## Reference

[Apple: Material](https://developer.apple.com/documentation/swiftui/material).

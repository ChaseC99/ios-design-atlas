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
<!-- captures:end -->

## Full example

[Open the complete runnable example](MaterialVersusOpacityDemo.swift).

## Reference

[Apple: Material](https://developer.apple.com/documentation/swiftui/material).

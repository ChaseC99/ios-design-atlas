---
id: "glass-containers"
title: "Joining glass elements"
summary: "Spacing and unions control how neighboring surfaces combine."
category: "Materials"
family: "Liquid Glass"
order: 805
kind: "native"
demoMinIOS: "26.0"
swiftFile: "GlassContainersDemo.swift"
view: "GlassContainersDemo"
captureNavigation: true
captureStyle: "screen"
apis: ["GlassEffectContainer", "glassEffectUnion"]
tags: ["spacing", "union", "joining"]
---

# Joining glass elements

A glass effect container lets nearby surfaces blend together; a shared union identifier combines selected effects into one shape.

## SwiftUI

```swift
import SwiftUI

@available(iOS 26.0, *)
struct JoinedGlass: View {
    @Namespace private var namespace
    var body: some View {
        GlassEffectContainer(spacing: 24) {
            HStack(spacing: 12) {
                ForEach(["sun.max", "moon"], id: \.self) { symbol in
                    Image(systemName: symbol).font(.title)
                        .frame(width: 64, height: 64)
                        .glassEffect(in: Circle())
                        .glassEffectUnion(id: "weather", namespace: namespace)
                }
            }
        }
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 18 Pro · iOS 27.0

default. light appearance; Large text; en_US.

![Joining glass elements on iPhone 18 Pro, iOS 27.0](captures/ios-27-0-iphone-18-pro-default-1792762710.041.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](GlassContainersDemo.swift).

## Reference

[Apple: GlassEffectContainer](https://developer.apple.com/documentation/swiftui/glasseffectcontainer).

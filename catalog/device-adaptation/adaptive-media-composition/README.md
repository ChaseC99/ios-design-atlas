---
id: "adaptive-media-composition"
title: "Adaptive media composition"
summary: "Use the available shape to choose where controls belong."
category: "Device adaptation"
family: "Adaptive foundations"
order: 2208
kind: "native"
demoMinIOS: "18.0"
swiftFile: "AdaptiveMediaCompositionDemo.swift"
view: "AdaptiveMediaCompositionDemo"
captureNavigation: true
ownsNavigation: false
captureStyle: "screen"
apis: ["GeometryReader", "AnyLayout", "aspectRatio"]
tags: ["media", "controls", "aspect ratio"]
---

# Adaptive media composition

A media composition can move its controls beside or below content using the current view size, without relying on screen dimensions or device orientation.

## SwiftUI

```swift
import SwiftUI

struct MediaAndControls: View {
    var body: some View {
        GeometryReader { proxy in
            let layout = proxy.size.width > 700
                ? AnyLayout(HStackLayout()) : AnyLayout(VStackLayout())
            layout {
                Rectangle().fill(.indigo.gradient)
                    .aspectRatio(16.0 / 9.0, contentMode: .fit)
                Button("Play", systemImage: "play.fill") { }
                    .buttonStyle(.bordered)
            }.padding()
        }
    }
}
```

## Captures

<!-- captures:start -->
### iPhone Duo · iOS 27.1

default. light appearance; Large text; en_US.

![Adaptive media composition on iPhone Duo, iOS 27.1](captures/ios-27-1-atlas-iphone-duo-default-1792765885.869.png)

### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Adaptive media composition on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792765364.93.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Adaptive media composition on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792765316.541.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](AdaptiveMediaCompositionDemo.swift).

## Reference

[Apple: GeometryReader](https://developer.apple.com/documentation/swiftui/geometryreader).

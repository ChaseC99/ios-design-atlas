---
id: "full-bleed-safe-areas"
title: "Full-bleed backgrounds"
summary: "Let artwork reach the edges while controls respect safe areas."
category: "Scroll edges"
family: "Safe areas"
order: 706
kind: "native"
demoMinIOS: "18.0"
swiftFile: "FullBleedSafeAreasDemo.swift"
view: "FullBleedSafeAreasDemo"
captureNavigation: true
captureStyle: "screen"
apis: ["ignoresSafeArea", "safeAreaInset"]
tags: ["background", "status bar", "home indicator"]
---

# Full-bleed backgrounds

A background can ignore the safe area while foreground content keeps the system’s clearance for bars and the home indicator.

## SwiftUI

```swift
import SwiftUI

struct EdgeToEdgeArtwork: View {
    var body: some View {
        ZStack {
            LinearGradient(colors: [.indigo, .teal],
                           startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            Text("Somewhere slower.")
                .font(.largeTitle).foregroundStyle(.white)
                .padding(32)
        }
        .safeAreaInset(edge: .bottom) {
            Button("Save this place") { }
                .buttonStyle(.borderedProminent).padding()
        }
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Full-bleed backgrounds on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792765838.208.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Full-bleed backgrounds on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792765570.313.png)

### iPhone 18 Pro · iOS 27.0

default. light appearance; Large text; en_US.

![Full-bleed backgrounds on iPhone 18 Pro, iOS 27.0](captures/ios-27-0-iphone-18-pro-default-1792767826.672.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](FullBleedSafeAreasDemo.swift).

## Reference

[Apple: ignoresSafeArea](https://developer.apple.com/documentation/swiftui/view/ignoressafearea(_:edges:)).

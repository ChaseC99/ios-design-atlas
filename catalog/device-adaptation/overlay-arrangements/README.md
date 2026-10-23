---
id: "overlay-arrangements"
title: "Native overlay arrangements"
summary: "Let a foreground panel move into its own region when needed."
category: "Device adaptation"
family: "iPhone Duo"
order: 2202
kind: "native"
demoMinIOS: "27.1"
swiftFile: "OverlayArrangementsDemo.swift"
view: "OverlayArrangementsDemo"
captureNavigation: true
ownsNavigation: false
captureStyle: "screen"
apis: ["ArrangementView", "overlayArrangementEdge"]
tags: ["overlay", "fold", "controls"]
---

# Native overlay arrangements

An overlay arrangement layers primary content over secondary content and can separate them around an active division region on a supported device.

These iOS 27.1 APIs are marked beta in Apple’s documentation and require iOS 27.1.

## SwiftUI

```swift
import SwiftUI

@available(iOS 27.1, *)
struct AdaptiveOverlay: View {
    var body: some View {
        ArrangementView {
            Text("Foreground controls").padding(24)
                .background(.regularMaterial, in: Capsule())
                .overlayArrangementEdge(.bottom)
        } secondary: {
            LinearGradient(colors: [.indigo, .orange],
                           startPoint: .top, endPoint: .bottom)
        }
        .arrangementViewStyle(.overlay)
    }
}
```

## Captures

<!-- captures:start -->
<!-- captures:end -->

## Full example

[Open the complete runnable example](OverlayArrangementsDemo.swift).

## Reference

[Apple: ArrangementView](https://developer.apple.com/documentation/swiftui/arrangementviewstyle/overlay).

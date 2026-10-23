---
id: "masks-blending-overlays"
title: "Masks, blending, and overlays"
summary: "Compose color and shape through transparency."
category: "Visuals"
family: "Composition"
order: 1608
kind: "native"
demoMinIOS: "18.0"
swiftFile: "MasksBlendingOverlaysDemo.swift"
view: "MasksBlendingOverlaysDemo"
captureNavigation: true
ownsNavigation: false
captureStyle: "screen"
apis: ["mask", "blendMode", "overlay", "compositingGroup"]
tags: ["gradient text", "multiply", "screen"]
---

# Masks, blending, and overlays

Masks use opacity to reveal content, while blend modes combine a foreground with the colors behind it.

## SwiftUI

```swift
import SwiftUI

struct GradientLettering: View {
    var body: some View {
        LinearGradient(colors: [.indigo, .teal, .orange],
                       startPoint: .leading, endPoint: .trailing)
            .frame(height: 120)
            .mask {
                Text("LIGHT")
                    .font(.system(size: 72, weight: .black, design: .rounded))
            }
            .accessibilityLabel("Light")
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Masks, blending, and overlays on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792766118.515.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Masks, blending, and overlays on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792765926.743.png)

### iPhone 18 Pro · iOS 27.0

default. light appearance; Large text; en_US.

![Masks, blending, and overlays on iPhone 18 Pro, iOS 27.0](captures/ios-27-0-iphone-18-pro-default-1792768124.69.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](MasksBlendingOverlaysDemo.swift).

## Reference

[Apple: mask](https://developer.apple.com/documentation/swiftui/view/mask(alignment:_:)).

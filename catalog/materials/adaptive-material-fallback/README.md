---
id: "adaptive-material-fallback"
title: "Adaptive surfaces and fallbacks"
summary: "Use glass when available and an opaque surface when requested."
category: "Materials"
family: "Adaptation"
order: 808
kind: "native"
demoMinIOS: "18.0"
swiftFile: "AdaptiveMaterialFallbackDemo.swift"
view: "AdaptiveMaterialFallbackDemo"
captureNavigation: true
captureStyle: "screen"
apis: ["accessibilityReduceTransparency", "colorSchemeContrast", "glassEffect"]
tags: ["accessibility", "fallback", "iOS versions"]
---

# Adaptive surfaces and fallbacks

A custom surface can use Liquid Glass on newer systems, a material on older systems, and an opaque treatment when Reduce Transparency is enabled.

## SwiftUI

```swift
import SwiftUI

struct AdaptiveSurface: View {
    @Environment(\.accessibilityReduceTransparency) private var opaque
    private var label: some View {
        Label("Saved places", systemImage: "bookmark").padding(24)
    }
    var body: some View {
        if opaque {
            label.background(Color(uiColor: .systemBackground), in: Capsule())
        } else if #available(iOS 26.0, *) {
            label.glassEffect()
        } else {
            label.background(.regularMaterial, in: Capsule())
        }
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 18 Pro · iOS 27.0

default. light appearance; Large text; en_US.

![Adaptive surfaces and fallbacks on iPhone 18 Pro, iOS 27.0](captures/ios-27-0-iphone-18-pro-default-1792762644.709.png)

### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Adaptive surfaces and fallbacks on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792765358.884.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Adaptive surfaces and fallbacks on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792765309.308.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](AdaptiveMaterialFallbackDemo.swift).

## Reference

[Apple: accessibilityReduceTransparency](https://developer.apple.com/documentation/swiftui/environmentvalues/accessibilityreducetransparency).

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
<!-- captures:end -->

## Full example

[Open the complete runnable example](AdaptiveMaterialFallbackDemo.swift).

## Reference

[Apple: accessibilityReduceTransparency](https://developer.apple.com/documentation/swiftui/environmentvalues/accessibilityreducetransparency).

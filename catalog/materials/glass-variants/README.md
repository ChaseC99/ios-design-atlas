---
id: "glass-variants"
title: "Regular, clear, and tinted glass"
summary: "Different glass treatments on the same background."
category: "Materials"
family: "Liquid Glass"
order: 803
kind: "native"
demoMinIOS: "26.0"
swiftFile: "GlassVariantsDemo.swift"
view: "GlassVariantsDemo"
captureNavigation: true
captureStyle: "screen"
apis: ["glassEffect", "Glass"]
tags: ["regular", "clear", "tint"]
---

# Regular, clear, and tinted glass

Liquid Glass provides regular and clear treatments for custom controls, with optional tinting to give an action emphasis.

## SwiftUI

```swift
import SwiftUI

@available(iOS 26.0, *)
struct TintedGlassControl: View {
    @State private var saved = false
    var body: some View {
        Button { saved.toggle() } label: {
            Label(saved ? "Saved" : "Save", systemImage: "bookmark")
                .padding(.horizontal, 24).padding(.vertical, 16)
        }
        .buttonStyle(.plain)
        .glassEffect(.regular.tint(.teal).interactive(), in: Capsule())
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 18 Pro · iOS 27.0

default. light appearance; Large text; en_US.

![Regular, clear, and tinted glass on iPhone 18 Pro, iOS 27.0](captures/ios-27-0-iphone-18-pro-default-1792762736.985.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Regular, clear, and tinted glass on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792765625.055.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](GlassVariantsDemo.swift).

## Reference

[Apple: glassEffect](https://developer.apple.com/documentation/swiftui/glass).

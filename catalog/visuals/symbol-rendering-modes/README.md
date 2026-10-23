---
id: "symbol-rendering-modes"
title: "SF Symbols rendering modes"
summary: "Monochrome, hierarchical, palette, and multicolor treatments."
category: "Visuals"
family: "Symbols"
order: 1601
kind: "native"
demoMinIOS: "18.0"
swiftFile: "SymbolRenderingModesDemo.swift"
view: "SymbolRenderingModesDemo"
captureNavigation: true
ownsNavigation: false
captureStyle: "screen"
apis: ["symbolRenderingMode", "foregroundStyle"]
tags: ["monochrome", "hierarchical", "palette", "multicolor"]
---

# SF Symbols rendering modes

Symbol rendering modes choose whether a symbol uses one color, layered emphasis, a custom palette, or its built-in colors.

## SwiftUI

```swift
import SwiftUI

struct PaletteSymbol: View {
    var body: some View {
        Image(systemName: "cloud.sun.rain.fill")
            .symbolRenderingMode(.palette)
            .foregroundStyle(.orange, .teal, .indigo)
            .font(.system(size: 80))
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![SF Symbols rendering modes on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792766850.512.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![SF Symbols rendering modes on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792766550.189.png)

### iPhone 18 Pro · iOS 27.0

default. light appearance; Large text; en_US.

![SF Symbols rendering modes on iPhone 18 Pro, iOS 27.0](captures/ios-27-0-iphone-18-pro-default-1792768702.653.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](SymbolRenderingModesDemo.swift).

## Reference

[Apple: symbolRenderingMode](https://developer.apple.com/documentation/swiftui/view/symbolrenderingmode(_:)).

---
id: "symbol-variants-alignment"
title: "Symbol variants and alignment"
summary: "Match icon weight, scale, and baseline to nearby text."
category: "Visuals"
family: "Symbols"
order: 1602
kind: "native"
demoMinIOS: "18.0"
swiftFile: "SymbolVariantsAlignmentDemo.swift"
view: "SymbolVariantsAlignmentDemo"
captureNavigation: true
ownsNavigation: false
captureStyle: "screen"
apis: ["symbolVariant", "imageScale", "Font.Weight"]
tags: ["filled", "outline", "baseline", "label"]
---

# Symbol variants and alignment

Symbol variants change a symbol’s shape, while font weight and image scale help it sit naturally alongside text.

## SwiftUI

```swift
import SwiftUI

struct FilledLabel: View {
    var body: some View {
        Label("Favorites", systemImage: "star")
            .symbolVariant(.fill)
            .font(.title2.weight(.medium))
            .imageScale(.large)
            .foregroundStyle(.orange)
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Symbol variants and alignment on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792766857.349.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Symbol variants and alignment on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792766556.414.png)

### iPhone 18 Pro · iOS 27.0

default. light appearance; Large text; en_US.

![Symbol variants and alignment on iPhone 18 Pro, iOS 27.0](captures/ios-27-0-iphone-18-pro-default-1792768713.079.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](SymbolVariantsAlignmentDemo.swift).

## Reference

[Apple: symbolVariant](https://developer.apple.com/documentation/swiftui/view/symbolvariant(_:)).

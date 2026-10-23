---
id: "font-design-weight-width"
title: "Font design, weight, and width"
summary: "Change the character of system typography."
category: "Typography"
family: "Type design"
order: 1502
kind: "native"
demoMinIOS: "18.0"
swiftFile: "FontDesignWeightWidthDemo.swift"
view: "FontDesignWeightWidthDemo"
captureNavigation: true
ownsNavigation: false
captureStyle: "screen"
apis: ["Font.Design", "Font.Weight", "fontWidth"]
tags: ["serif", "rounded", "monospaced", "condensed"]
---

# Font design, weight, and width

System fonts offer different designs, weights, and widths while retaining the platform’s text metrics and accessibility behavior.

## SwiftUI

```swift
import SwiftUI

struct SystemFontDesign: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Make room for wonder.")
                .font(.system(.largeTitle, design: .serif).weight(.medium))
            Text("A small observation.")
                .font(.title2).fontWidth(.condensed)
        }.padding()
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Font design, weight, and width on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792765629.926.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Font design, weight, and width on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792765554.409.png)

### iPhone 18 Pro · iOS 27.0

default. light appearance; Large text; en_US.

![Font design, weight, and width on iPhone 18 Pro, iOS 27.0](captures/ios-27-0-iphone-18-pro-default-1792767803.191.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](FontDesignWeightWidthDemo.swift).

## Reference

[Apple: Font.Design](https://developer.apple.com/documentation/swiftui/font/design).

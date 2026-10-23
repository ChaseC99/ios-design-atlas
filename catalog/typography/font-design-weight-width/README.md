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
<!-- captures:end -->

## Full example

[Open the complete runnable example](FontDesignWeightWidthDemo.swift).

## Reference

[Apple: Font.Design](https://developer.apple.com/documentation/swiftui/font/design).

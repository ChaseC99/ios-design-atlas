---
id: "sheet-appearance"
title: "Sheet appearance"
summary: "Shape, surface, and a small invitation to drag."
category: "Sheets"
family: "Appearance"
order: 104
kind: "native"
demoMinIOS: "18.0"
swiftFile: "SheetAppearanceDemo.swift"
view: "SheetAppearanceDemo"
apis: ["presentationDragIndicator", "presentationCornerRadius", "presentationBackground"]
tags: ["material", "color", "gradient", "corner-radius"]
captureNavigation: false
captureStyle: "screen"
---

# Sheet appearance

A sheet keeps its native presentation behavior while you adjust its drag indicator, corner radius, and background. Materials, colors, and custom background views offer different levels of separation from the content underneath.

## SwiftUI

```swift
import SwiftUI

struct SheetAppearanceRecipe: View {
    @State private var isPresented = false

    var body: some View {
        Button("Show collection") { isPresented = true }
            .sheet(isPresented: $isPresented) {
                Text("Weekend references").font(.title2.bold()).padding(32)
                    .presentationDetents([.medium, .large])
                    .presentationDragIndicator(.visible)
                    .presentationCornerRadius(32)
                    .presentationBackground(.thinMaterial)
            }
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Sheet appearance on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792762423.078.png)

### iPhone 18 Pro · iOS 27.0

default. light appearance; Large text; en_US.

![Sheet appearance on iPhone 18 Pro, iOS 27.0](captures/ios-27-0-iphone-18-pro-default-1792762963.995.png)

### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Sheet appearance on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792766721.548.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](SheetAppearanceDemo.swift).

## Reference

[Apple: sheets](https://developer.apple.com/design/human-interface-guidelines/sheets).

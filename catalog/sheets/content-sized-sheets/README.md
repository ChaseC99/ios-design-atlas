---
id: "content-sized-sheets"
title: "Content-sized sheets"
summary: "Let a presentation fit the content inside it."
category: "Sheets"
family: "Sizing"
order: 103
kind: "native"
demoMinIOS: "18.0"
swiftFile: "ContentSizedSheetsDemo.swift"
view: "ContentSizedSheetsDemo"
apis: ["presentationSizing", "FittedPresentationSizing", "sticky"]
tags: ["content", "resizing", "intrinsic-size"]
captureNavigation: false
captureStyle: "screen"
---

# Content-sized sheets

Fitted presentation sizing asks the system to size a sheet around its content. A stable width keeps the layout calm while added details change the preferred height; the final geometry still depends on the device and available space.

## SwiftUI

```swift
import SwiftUI

struct FittedSheetRecipe: View {
    @State private var isPresented = false
    @State private var showsDetails = false

    var body: some View {
        Button("Show invitation") { isPresented = true }
            .sheet(isPresented: $isPresented) {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Saturday by the sea").font(.title2.bold())
                    Toggle("Show details", isOn: $showsDetails)
                    if showsDetails { Text("Meet at the harbor at 9:00 AM.") }
                }
                .padding(28)
                .frame(idealWidth: 360)
                .presentationSizing(.fitted.sticky(horizontal: true))
            }
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Content-sized sheets on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792762408.636.png)

### iPhone 18 Pro · iOS 27.0

default. light appearance; Large text; en_US.

![Content-sized sheets on iPhone 18 Pro, iOS 27.0](captures/ios-27-0-iphone-18-pro-default-1792762682.813.png)

### iPad Pro 11-inch (M5) · iOS 27.0

Compact centered sheet shows complete content and controls; no clipping.. light appearance; Large text; en_US.

![Content-sized sheets on iPad Pro 11-inch (M5), iOS 27.0](captures/ios-27-0-ipad-pro-11-inch-m5-default-1792768505.926.png)

### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Content-sized sheets on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792770582.514.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](ContentSizedSheetsDemo.swift).

## Reference

[Apple: sheets](https://developer.apple.com/design/human-interface-guidelines/sheets).

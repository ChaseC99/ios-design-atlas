---
id: "sheet-adaptation"
title: "Compact sheet adaptation"
summary: "Let a presentation respond to the available room."
category: "Sheets"
family: "Adaptation"
order: 112
kind: "native"
demoMinIOS: "18.0"
swiftFile: "SheetAdaptationDemo.swift"
view: "SheetAdaptationDemo"
apis: ["presentationCompactAdaptation", "presentationSizing", "horizontalSizeClass", "verticalSizeClass"]
tags: ["compact", "regular", "landscape", "ipad"]
captureNavigation: false
captureStyle: "screen"
---

# Compact sheet adaptation

Sheets adapt as horizontal and vertical space changes. A compact adaptation preference lets you compare the system default with a sheet or full-screen treatment; rotate an iPhone or resize an iPad window to see where the policy takes effect.

## SwiftUI

```swift
import SwiftUI

struct SheetAdaptationRecipe: View {
    @State private var isPresented = false

    var body: some View {
        Button("Show packing list") { isPresented = true }
            .sheet(isPresented: $isPresented) {
                List(["Notebook", "Water bottle", "Light jacket"], id: \.self) {
                    Text($0)
                }
                .presentationSizing(.form)
                .presentationCompactAdaptation(.sheet)
            }
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Compact sheet adaptation on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792762416.481.png)

### iPhone 18 Pro · iOS 27.0

default. light appearance; Large text; en_US.

![Compact sheet adaptation on iPhone 18 Pro, iOS 27.0](captures/ios-27-0-iphone-18-pro-default-1792762955.287.png)

### iPad Pro 11-inch (M5) · iOS 27.0

Centered native form presentation is visible and legible.. light appearance; Large text; en_US.

![Compact sheet adaptation on iPad Pro 11-inch (M5), iOS 27.0](captures/ios-27-0-ipad-pro-11-inch-m5-default-1792768604.617.png)

### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Compact sheet adaptation on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792771036.438.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](SheetAdaptationDemo.swift).

## Reference

[Apple: sheets](https://developer.apple.com/design/human-interface-guidelines/sheets).

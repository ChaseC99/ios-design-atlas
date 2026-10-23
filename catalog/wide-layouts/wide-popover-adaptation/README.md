---
id: "wide-popover-adaptation"
title: "An anchored popover"
summary: "Show options beside their control when space allows."
category: "Wide layouts"
family: "Presentation adaptation"
order: 2305
kind: "native"
demoMinIOS: "18.0"
swiftFile: "WidePopoverAdaptationDemo.swift"
view: "WidePopoverAdaptationDemo"
captureNavigation: true
ownsNavigation: false
captureStyle: "screen"
apis: ["popover", "presentationCompactAdaptation"]
tags: ["iPad", "popover", "sheet"]
---

# An anchored popover

A popover remains anchored in a regular-width context and adapts to a sheet in compact contexts; changing its settings updates the underlying card.

## SwiftUI

```swift
import SwiftUI

struct AnchoredOptions: View {
    @State private var presented = false
    @State private var showDate = true
    var body: some View {
        Button("Options", systemImage: "slider.horizontal.3") { presented = true }
            .popover(isPresented: $presented, arrowEdge: .top) {
                Toggle("Show date", isOn: $showDate).padding(24)
                    .frame(idealWidth: 300, idealHeight: 140)
                    .presentationCompactAdaptation(.sheet)
            }
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![An anchored popover on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792766985.646.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![An anchored popover on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792766713.679.png)

### iPad Pro 11-inch (M5) · iOS 27.0

Popover content and source are visible over the postcard. No obvious clipping; native translucent surface is expected.. light appearance; Large text; en_US.

![An anchored popover on iPad Pro 11-inch (M5), iOS 27.0](captures/ios-27-0-ipad-pro-11-inch-m5-default-1792768656.173.png)

### iPhone 18 Pro · iOS 27.0

default. light appearance; Large text; en_US.

![An anchored popover on iPhone 18 Pro, iOS 27.0](captures/ios-27-0-iphone-18-pro-default-1792768890.239.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](WidePopoverAdaptationDemo.swift).

## Reference

[Apple: popover](https://developer.apple.com/documentation/swiftui/view/popover(ispresented:attachmentanchor:arrowedge:content:)).

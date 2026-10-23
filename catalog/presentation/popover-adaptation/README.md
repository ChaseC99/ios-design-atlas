---
id: "popover-adaptation"
title: "Popover adaptation"
summary: "One view, two presentation contexts."
category: "Presentation"
family: "Popovers"
order: 5
kind: "native"
demoMinIOS: "18.0"
swiftFile: "PopoverAdaptationDemo.swift"
view: "PopoverAdaptationDemo"
apis: ["popover", "presentationCompactAdaptation"]
tags: ["compact", "sheet", "adaptive"]
captureNavigation: false
captureStyle: "screen"
---

# Popover adaptation

A popover can adapt to a sheet in compact layouts, or request an anchored presentation with presentationCompactAdaptation.

## SwiftUI

```swift
import SwiftUI

struct ReadingPopover: View {
    @State private var showing = false
    var body: some View {
        Button("Reading options") { showing = true }
            .popover(isPresented: $showing) {
                Text("Reading options")
                    .padding(24)
                    .presentationCompactAdaptation(.popover)
            }
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 18 Pro · iOS 27.0

default. light appearance; Large text; en_US.

![Popover adaptation on iPhone 18 Pro, iOS 27.0](captures/ios-27-0-iphone-18-pro-default-1792762855.182.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](PopoverAdaptationDemo.swift).

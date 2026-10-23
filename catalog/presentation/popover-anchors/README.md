---
id: "popover-anchors"
title: "Popover anchors"
summary: "Keep a little context close to its source."
category: "Presentation"
family: "Popovers"
order: 4
kind: "native"
demoMinIOS: "18.0"
swiftFile: "PopoverAnchorsDemo.swift"
view: "PopoverAnchorsDemo"
apis: ["popover", "PopoverAttachmentAnchor", "presentationCompactAdaptation"]
tags: ["anchor", "arrow", "sizing"]
captureNavigation: false
captureStyle: "screen"
---

# Popover anchors

A popover attaches a small surface to its source control; the system uses the anchor, requested arrow edge, and available space to place it.

## SwiftUI

```swift
import SwiftUI

struct AnchoredPopover: View {
    @State private var showing = false
    var body: some View {
        Button("Details", systemImage: "info.circle") { showing = true }
            .popover(isPresented: $showing,
                     attachmentAnchor: .rect(.bounds),
                     arrowEdge: .top) {
                Text("A little more context.")
                    .padding(24)
                    .frame(width: 280)
                    .presentationCompactAdaptation(.popover)
            }
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 18 Pro · iOS 27.0

default. light appearance; Large text; en_US.

![Popover anchors on iPhone 18 Pro, iOS 27.0](captures/ios-27-0-iphone-18-pro-default-1792762864.287.png)

### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Popover anchors on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792766405.177.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Popover anchors on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792766166.725.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](PopoverAnchorsDemo.swift).

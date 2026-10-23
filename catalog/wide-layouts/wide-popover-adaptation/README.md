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
<!-- captures:end -->

## Full example

[Open the complete runnable example](WidePopoverAdaptationDemo.swift).

## Reference

[Apple: popover](https://developer.apple.com/documentation/swiftui/view/popover(ispresented:attachmentanchor:arrowedge:content:)).

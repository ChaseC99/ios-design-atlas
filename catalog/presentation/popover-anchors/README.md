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
<!-- captures:end -->

## Full example

[Open the complete runnable example](PopoverAnchorsDemo.swift).

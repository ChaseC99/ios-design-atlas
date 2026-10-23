---
id: "scroll-snapping"
title: "Paging and view-aligned snapping"
summary: "Snap to the viewport or align to individual cards."
category: "Scrolling"
family: "Targets"
order: 602
kind: "native"
demoMinIOS: "18.0"
swiftFile: "ScrollSnappingDemo.swift"
view: "ScrollSnappingDemo"
captureNavigation: true
ownsNavigation: false
captureStyle: "screen"
apis: ["scrollTargetBehavior", "scrollTargetLayout", "containerRelativeFrame"]
tags: ["paging", "view aligned", "indicators"]
---

# Paging and view-aligned snapping

Paging snaps by the scroll view’s size, while view-aligned scrolling settles on the bounds of a marked target view.

## SwiftUI

```swift
import SwiftUI

struct SnappingCards: View {
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 16) {
                ForEach(1...8, id: \.self) { number in
                    Text("Study \(number)")
                        .frame(width: 260, height: 320)
                        .background(.teal.gradient, in: RoundedRectangle(cornerRadius: 24))
                }
            }.scrollTargetLayout()
        }
        .contentMargins(.horizontal, 24, for: .scrollContent)
        .scrollTargetBehavior(.viewAligned)
    }
}
```

## Captures

<!-- captures:start -->
<!-- captures:end -->

## Full example

[Open the complete runnable example](ScrollSnappingDemo.swift).

## Reference

[Apple: scrollTargetBehavior](https://developer.apple.com/documentation/swiftui/view/scrolltargetbehavior(_:)).

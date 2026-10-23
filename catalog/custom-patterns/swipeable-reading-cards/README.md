---
id: "swipeable-reading-cards"
title: "Swipeable reading cards"
summary: "Save or skip a card with a gesture or explicit button."
category: "Custom patterns"
family: "Card patterns"
order: 3408
kind: "custom"
demoMinIOS: "18.0"
swiftFile: "SwipeableReadingCardsDemo.swift"
view: "SwipeableReadingCardsDemo"
captureNavigation: true
ownsNavigation: false
captureStyle: "screen"
apis: ["DragGesture", "rotationEffect", "accessibilityAction"]
tags: ["custom", "swipe", "cards"]
---

# Swipeable reading cards

A custom card stack offers swipe decisions with equivalent buttons and accessibility actions. Use native `List.swipeActions` when the content belongs in a list.

## SwiftUI

```swift
import SwiftUI

struct SwipeDecision: View {
    @GestureState private var offset: CGFloat = 0
    @State private var saved = false
    var body: some View {
        Text(saved ? "Saved" : "Swipe right to save")
            .padding(40).background(.teal.opacity(0.1), in: .rect(cornerRadius: 24))
            .offset(x: offset)
            .gesture(DragGesture()
                .updating($offset) { value, offset, _ in offset = value.translation.width }
                .onEnded { value in
                    if value.translation.width > 100 { saved = true }
                })
            .accessibilityAction(named: "Save") { saved = true }
        Button("Save") { saved = true }
    }
}
```

## Captures

<!-- captures:start -->
<!-- captures:end -->

## Full example

[Open the complete runnable example](SwipeableReadingCardsDemo.swift).

## Reference

[Apple documentation](https://developer.apple.com/documentation/swiftui/draggesture).

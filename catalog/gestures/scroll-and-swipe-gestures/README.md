---
id: "scroll-and-swipe-gestures"
title: "Swiping inside a scroll view"
summary: "Compare simultaneous and competing drag gestures."
category: "Gestures"
family: "Gesture arbitration"
order: 1903
kind: "custom"
demoMinIOS: "18.0"
swiftFile: "ScrollSwipeGesturesDemo.swift"
view: "ScrollSwipeGesturesDemo"
apis: ["DragGesture", "simultaneousGesture", "highPriorityGesture", "GestureState"]
tags: ["scroll", "swipe", "gesture-priority", "reduce-motion", "cancellation"]
captureNavigation: true
captureStyle: "screen"
---

# Swiping inside a scroll view

A custom horizontal swipe can reveal an action inside vertical scrolling content. Simultaneous and high-priority attachment change how the gestures compete; the direction check filters horizontal updates but does not change system gesture recognition. Captures show the revealed resting state.

## SwiftUI

```swift
import SwiftUI

struct SwipeRecipe: View {
    @State private var open = false
    @State private var favorite = false
    @GestureState private var translation = 0.0
    var body: some View {
        ScrollView {
            ZStack(alignment: .trailing) {
                Button(favorite ? "Unsave" : "Favorite") { favorite.toggle(); open = false }
                    .frame(width: 96)
                Text(favorite ? "Saved place" : "A wider horizon")
                    .padding(30).frame(maxWidth: .infinity)
                    .background(Color(.secondarySystemBackground))
                    .offset(x: min(0, max(-96, (open ? -96 : 0) + translation)))
                    .simultaneousGesture(DragGesture(minimumDistance: 15)
                        .updating($translation) { value, state, _ in
                            if abs(value.translation.width) > abs(value.translation.height) {
                                state = value.translation.width
                            }
                        }
                        .onEnded { value in
                            guard abs(value.translation.width) > abs(value.translation.height) else { return }
                            open = (open ? -96 : 0) + value.translation.width < -48
                        })
                    .accessibilityAction(named: "Toggle favorite") { favorite.toggle() }
            }.background(.pink.opacity(0.15)).clipped()
        }
    }
}
```

## Captures

<!-- captures:start -->
Captures have not been recorded yet.
<!-- captures:end -->

## Full example

[Open the complete runnable example](ScrollSwipeGesturesDemo.swift).

## Reference

[Apple: gestures](https://developer.apple.com/design/human-interface-guidelines/gestures).

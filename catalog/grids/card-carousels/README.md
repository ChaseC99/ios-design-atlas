---
id: "card-carousels"
title: "Card carousels"
summary: "A horizontal carousel can reveal the next card and snap each item into a readable position."
category: "Grids"
family: "Carousels"
order: 1004
kind: "native"
demoMinIOS: "18.0"
swiftFile: "CardCarouselsDemo.swift"
view: "CardCarouselsDemo"
captureNavigation: true
ownsNavigation: false
apis: ["scrollTargetBehavior", "scrollTargetLayout", "scrollPosition", "containerRelativeFrame"]
tags: ["peek", "paging", "view aligned", "indicators"]
---

# Card carousels

A horizontal carousel can reveal the next card and snap each item into a readable position.

## SwiftUI

```swift
import SwiftUI

struct PeekingCarousel: View {
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 16) {
                ForEach(0..<5) { index in
                    Text("Place \(index + 1)")
                        .font(.title)
                        .frame(height: 280)
                        .containerRelativeFrame(.horizontal) { width, _ in width * 0.84 }
                        .background(.teal.opacity(0.15), in: .rect(cornerRadius: 24))
                }
            }
            .scrollTargetLayout()
        }
        .contentMargins(.horizontal, 24, for: .scrollContent)
        .scrollTargetBehavior(.viewAligned)
        .scrollIndicators(.hidden)
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Card carousels on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792765485.928.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Card carousels on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792765392.511.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](CardCarouselsDemo.swift).

## Reference

[Apple: scrollTargetBehavior](https://developer.apple.com/documentation/swiftui/view/scrolltargetbehavior(_:)).

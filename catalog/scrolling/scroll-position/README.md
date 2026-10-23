---
id: "scroll-position"
title: "Programmatic scroll position"
summary: "Jump to a target, an edge, or a specific offset."
category: "Scrolling"
family: "Targets"
order: 603
kind: "native"
demoMinIOS: "18.0"
swiftFile: "ScrollPositionDemo.swift"
view: "ScrollPositionDemo"
captureNavigation: true
ownsNavigation: false
captureStyle: "screen"
apis: ["ScrollPosition", "scrollPosition", "defaultScrollAnchor"]
tags: ["programmatic", "initial anchor", "scroll to top"]
---

# Programmatic scroll position

A scroll-position binding can move a scroll view to a stable item identifier, an edge, or an explicit content offset.

## SwiftUI

```swift
import SwiftUI

struct JumpToItem: View {
    @State private var position = ScrollPosition(idType: Int.self)
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(1...50, id: \.self) { number in
                    Text("Item \(number)").padding().id(number)
                }
            }.scrollTargetLayout()
        }
        .scrollPosition($position)
        .safeAreaInset(edge: .bottom) {
            Button("Jump to 25") {
                withAnimation { position.scrollTo(id: 25, anchor: .center) }
            }.padding()
        }
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Programmatic scroll position on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792766540.282.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Programmatic scroll position on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792766355.154.png)

### iPhone 18 Pro · iOS 27.0

default. light appearance; Large text; en_US.

![Programmatic scroll position on iPhone 18 Pro, iOS 27.0](captures/ios-27-0-iphone-18-pro-default-1792768461.301.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](ScrollPositionDemo.swift).

## Reference

[Apple: ScrollPosition](https://developer.apple.com/documentation/swiftui/scrollposition).

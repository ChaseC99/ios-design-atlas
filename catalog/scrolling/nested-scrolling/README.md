---
id: "nested-scrolling"
title: "Nested scrolling and carousels"
summary: "A vertical collection of independently scrolling horizontal shelves."
category: "Scrolling"
family: "Axes"
order: 601
kind: "native"
demoMinIOS: "18.0"
swiftFile: "NestedScrollingDemo.swift"
view: "NestedScrollingDemo"
captureNavigation: true
ownsNavigation: false
captureStyle: "screen"
apis: ["ScrollView", "LazyHStack", "LazyVStack"]
tags: ["horizontal", "vertical", "carousel"]
---

# Nested scrolling and carousels

Nested scroll views let a page move vertically while each shelf scrolls horizontally through its own collection.

## SwiftUI

```swift
import SwiftUI

struct Shelves: View {
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 24) {
                ForEach(0..<5) { shelf in
                    ScrollView(.horizontal) {
                        LazyHStack {
                            ForEach(0..<8) { item in
                                Text("\(shelf + 1).\(item + 1)")
                                    .frame(width: 180, height: 140)
                                    .background(.teal.opacity(0.15), in: RoundedRectangle(cornerRadius: 20))
                            }
                        }.padding(.horizontal)
                    }
                }
            }
        }
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Nested scrolling and carousels on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792766279.106.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Nested scrolling and carousels on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792766096.361.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](NestedScrollingDemo.swift).

## Reference

[Apple: ScrollView](https://developer.apple.com/documentation/swiftui/scrollview).

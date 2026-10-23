---
id: "scroll-content-margins"
title: "Content and indicator margins"
summary: "Inset the reading column while keeping the indicator near the edge."
category: "Scroll edges"
family: "Margins"
order: 705
kind: "native"
demoMinIOS: "18.0"
swiftFile: "ScrollContentMarginsDemo.swift"
view: "ScrollContentMarginsDemo"
captureNavigation: true
captureStyle: "screen"
apis: ["contentMargins", "ContentMarginPlacement"]
tags: ["readable width", "scroll indicators", "full bleed"]
---

# Content and indicator margins

Content margins can move a scroll view’s content without moving its scroll indicators, or adjust each independently.

## SwiftUI

```swift
import SwiftUI

struct IndependentScrollMargins: View {
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                ForEach(1...40, id: \.self) { Text("Observation \($0)").padding(.vertical) }
            }.frame(maxWidth: .infinity, alignment: .leading)
        }
        .contentMargins(.horizontal, 28, for: .scrollContent)
        .contentMargins(.trailing, 2, for: .scrollIndicators)
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 18 Pro · iOS 27.0

default. light appearance; Large text; en_US.

![Content and indicator margins on iPhone 18 Pro, iOS 27.0](captures/ios-27-0-iphone-18-pro-default-1792762918.741.png)

### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Content and indicator margins on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792766533.956.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Content and indicator margins on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792766279.149.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](ScrollContentMarginsDemo.swift).

## Reference

[Apple: contentMargins](https://developer.apple.com/documentation/swiftui/view/contentmargins(_:_:for:)).

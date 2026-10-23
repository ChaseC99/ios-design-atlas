---
id: "text-wrapping-truncation"
title: "Wrapping, truncation, and scaling"
summary: "Choose which constraint a line of text should respect."
category: "Typography"
family: "Layout"
order: 1504
kind: "native"
demoMinIOS: "18.0"
swiftFile: "TextWrappingTruncationDemo.swift"
view: "TextWrappingTruncationDemo"
captureNavigation: true
ownsNavigation: false
captureStyle: "screen"
apis: ["lineLimit", "truncationMode", "minimumScaleFactor", "fixedSize"]
tags: ["wrapping", "truncation", "compression"]
---

# Wrapping, truncation, and scaling

Line limits, truncation, minimum scaling, and fixed sizing produce different results when text has less space than it needs.

## SwiftUI

```swift
import SwiftUI

struct ConstrainedTitle: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Somewhere between the sea and the sky")
                .lineLimit(1).truncationMode(.middle)
            Text("Somewhere between the sea and the sky")
                .lineLimit(1).minimumScaleFactor(0.6)
            Text("Somewhere between the sea and the sky")
                .fixedSize(horizontal: false, vertical: true)
        }.font(.title2).frame(width: 260)
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Wrapping, truncation, and scaling on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792766908.913.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Wrapping, truncation, and scaling on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792766637.569.png)

### iPhone 18 Pro · iOS 27.0

default. light appearance; Large text; en_US.

![Wrapping, truncation, and scaling on iPhone 18 Pro, iOS 27.0](captures/ios-27-0-iphone-18-pro-default-1792768787.165.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](TextWrappingTruncationDemo.swift).

## Reference

[Apple: lineLimit](https://developer.apple.com/documentation/swiftui/view/linelimit(_:)).

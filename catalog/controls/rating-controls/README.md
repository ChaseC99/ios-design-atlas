---
id: "rating-controls"
title: "Rating controls"
summary: "Make a custom value accessible to touch and VoiceOver."
category: "Controls"
family: "Custom controls"
order: 1208
kind: "custom"
demoMinIOS: "18.0"
swiftFile: "RatingControlsDemo.swift"
view: "RatingControlsDemo"
apis: ["accessibilityAdjustableAction", "accessibilityValue", "Button"]
tags: ["custom", "rating", "accessibility", "adjustable"]
captureNavigation: true
captureStyle: "screen"
---

# Rating controls

A custom rating control can use individual buttons for touch and expose one adjustable value to VoiceOver. Clear bounds, a spoken value, and a way to reset the rating make the interaction complete.

## SwiftUI

```swift
import SwiftUI

struct RatingRecipe: View {
    @State private var rating = 3
    var body: some View {
        HStack {
            ForEach(1...5, id: \.self) { value in
                Button { rating = value } label: {
                    Image(systemName: value <= rating ? "star.fill" : "star")
                        .frame(minWidth: 44, minHeight: 44)
                }
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Rating")
        .accessibilityValue("\(rating) out of 5 stars")
        .accessibilityAdjustableAction { direction in
            switch direction {
            case .increment: rating = min(5, rating + 1)
            case .decrement: rating = max(0, rating - 1)
            @unknown default: break
            }
        }
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Rating controls on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792766443.221.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Rating controls on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792766191.184.png)

### iPhone 18 Pro · iOS 27.0

default. light appearance; Large text; en_US.

![Rating controls on iPhone 18 Pro, iOS 27.0](captures/ios-27-0-iphone-18-pro-default-1792768325.031.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](RatingControlsDemo.swift).

## Reference

[Apple: pickers](https://developer.apple.com/design/human-interface-guidelines/pickers).

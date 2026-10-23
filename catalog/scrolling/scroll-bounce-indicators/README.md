---
id: "scroll-bounce-indicators"
title: "Bounce and scroll indicators"
summary: "Choose how a short page behaves when it has little to scroll."
category: "Scrolling"
family: "Behavior"
order: 606
kind: "native"
demoMinIOS: "18.0"
swiftFile: "ScrollBounceIndicatorsDemo.swift"
view: "ScrollBounceIndicatorsDemo"
captureNavigation: true
ownsNavigation: false
captureStyle: "screen"
apis: ["scrollBounceBehavior", "scrollIndicators", "scrollIndicatorsFlash"]
tags: ["short content", "long content", "indicators"]
---

# Bounce and scroll indicators

Scroll bounce can depend on content size, while indicator visibility and flashing provide a separate cue that more content is available.

## SwiftUI

```swift
import SwiftUI

struct ContentSizedBounce: View {
    @State private var flash = 0
    var body: some View {
        ScrollView { Text("A short page").padding(32) }
            .scrollBounceBehavior(.basedOnSize)
            .scrollIndicators(.visible)
            .scrollIndicatorsFlash(trigger: flash)
            .safeAreaInset(edge: .bottom) {
                Button("Flash indicators") { flash += 1 }.padding()
            }
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Bounce and scroll indicators on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792766528.039.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Bounce and scroll indicators on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792766272.421.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](ScrollBounceIndicatorsDemo.swift).

## Reference

[Apple: scrollBounceBehavior](https://developer.apple.com/documentation/swiftui/view/scrollbouncebehavior(_:axes:)).

---
id: "resize-state-preservation"
title: "Preserving state while resizing"
summary: "Change the layout without recreating its stateful children."
category: "Device adaptation"
family: "Adaptive foundations"
order: 2207
kind: "native"
demoMinIOS: "18.0"
swiftFile: "ResizeStatePreservationDemo.swift"
view: "ResizeStatePreservationDemo"
captureNavigation: true
ownsNavigation: false
captureStyle: "screen"
apis: ["AnyLayout", "GeometryReader"]
tags: ["state", "resize", "focus", "identity"]
---

# Preserving state while resizing

AnyLayout changes a container’s layout while preserving the identities of its child views, including their local state.

## SwiftUI

```swift
import SwiftUI

struct ResizingCounter: View {
    @State private var count = 0
    var body: some View {
        GeometryReader { proxy in
            let layout = proxy.size.width > 600
                ? AnyLayout(HStackLayout()) : AnyLayout(VStackLayout())
            layout {
                Text("\(count)").font(.largeTitle)
                Button("Add one") { count += 1 }
            }.padding()
        }
    }
}
```

## Captures

<!-- captures:start -->
### iPhone Duo · iOS 27.1

default. light appearance; Large text; en_US.

![Preserving state while resizing on iPhone Duo, iOS 27.1](captures/ios-27-1-atlas-iphone-duo-default-1792765960.905.png)

### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Preserving state while resizing on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792766502.88.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Preserving state while resizing on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792766224.079.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](ResizeStatePreservationDemo.swift).

## Reference

[Apple: AnyLayout](https://developer.apple.com/documentation/swiftui/anylayout).

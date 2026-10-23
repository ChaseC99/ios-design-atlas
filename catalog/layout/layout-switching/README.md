---
id: "layout-switching"
title: "Switching layouts with AnyLayout"
summary: "Move the same views into a new arrangement."
category: "Layout"
family: "Adaptation"
order: 1706
kind: "native"
demoMinIOS: "18.0"
swiftFile: "LayoutSwitchingDemo.swift"
view: "LayoutSwitchingDemo"
apis: ["AnyLayout", "HStackLayout", "VStackLayout", "animation"]
tags: ["identity", "layout-transition", "state", "reduce-motion"]
captureNavigation: true
captureStyle: "screen"
---

# Switching layouts with AnyLayout

AnyLayout changes the layout algorithm while retaining the identity of its child views. This preserves local state as the arrangement changes; the app demonstrates the transition, while a capture shows one resting arrangement.

## SwiftUI

```swift
import SwiftUI

struct AnyLayoutRecipe: View {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var vertical = false
    var body: some View {
        let layout = vertical ? AnyLayout(VStackLayout(spacing: 16)) : AnyLayout(HStackLayout(spacing: 16))
        VStack(spacing: 24) {
            layout {
                Image(systemName: "leaf.fill")
                Text("Weekend references")
            }
            Toggle("Vertical layout", isOn: $vertical)
        }
        .animation(reduceMotion ? nil : .smooth, value: vertical)
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Switching layouts with AnyLayout on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792766028.936.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Switching layouts with AnyLayout on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792765796.578.png)

### iPhone 18 Pro · iOS 27.0

default. light appearance; Large text; en_US.

![Switching layouts with AnyLayout on iPhone 18 Pro, iOS 27.0](captures/ios-27-0-iphone-18-pro-default-1792768016.732.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](LayoutSwitchingDemo.swift).

## Reference

[Apple: layout](https://developer.apple.com/design/human-interface-guidelines/layout).

---
id: "scroll-edge-visibility"
title: "Scroll edge visibility"
summary: "Control which edges protect content beneath a bar."
category: "Scroll edges"
family: "Scroll edges"
order: 702
kind: "native"
demoMinIOS: "26.0"
swiftFile: "ScrollEdgeVisibilityDemo.swift"
view: "ScrollEdgeVisibilityDemo"
captureNavigation: true
captureStyle: "screen"
apis: ["scrollEdgeEffectHidden", "safeAreaBar"]
tags: ["horizontal", "vertical", "pinned headers"]
---

# Scroll edge visibility

Scroll edge visibility can be controlled per edge, including the leading and trailing edges of a horizontal scroller.

## SwiftUI

```swift
import SwiftUI

@available(iOS 26.0, *)
struct HiddenTopEdge: View {
    @State private var hidden = false
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Toggle("Hide top effect", isOn: $hidden)
                ForEach(1...30, id: \.self) { Text("Study \($0)") }
            }.padding()
        }
        .scrollEdgeEffectHidden(hidden, for: .top)
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 18 Pro · iOS 27.0

default. light appearance; Large text; en_US.

![Scroll edge visibility on iPhone 18 Pro, iOS 27.0](captures/ios-27-0-iphone-18-pro-default-1792762937.138.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Scroll edge visibility on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792766346.979.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](ScrollEdgeVisibilityDemo.swift).

## Reference

[Apple: scrollEdgeEffectHidden](https://developer.apple.com/documentation/swiftui/view/scrolledgeeffecthidden(_:for:)).

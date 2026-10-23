---
id: "scroll-edge-styles"
title: "Scroll edge styles"
summary: "Soft, hard, and automatic edges around native bars."
category: "Scroll edges"
family: "Scroll edges"
order: 701
kind: "native"
demoMinIOS: "26.0"
swiftFile: "ScrollEdgeStylesDemo.swift"
view: "ScrollEdgeStylesDemo"
captureNavigation: true
captureStyle: "screen"
captureScroll: true
apis: ["scrollEdgeEffectStyle", "ScrollEdgeEffectStyle"]
tags: ["scroll", "bars", "contrast"]
---

# Scroll edge styles

Scroll edge effects soften or separate content as it passes beneath system bars; the style can be set independently for each edge.

## SwiftUI

```swift
import SwiftUI

@available(iOS 26.0, *)
struct SoftScrollEdges: View {
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(1...40, id: \.self) { number in
                    Text("Field note \(number)").padding()
                }
            }.frame(maxWidth: .infinity)
        }
        .scrollEdgeEffectStyle(.soft, for: .top)
        .scrollEdgeEffectStyle(.hard, for: .bottom)
        .navigationTitle("Field notes")
    }
}
```

## Captures

<!-- captures:start -->
<!-- captures:end -->

## Full example

[Open the complete runnable example](ScrollEdgeStylesDemo.swift).

## Reference

[Apple: scrollEdgeEffectStyle](https://developer.apple.com/documentation/swiftui/scrolledgeeffectstyle).

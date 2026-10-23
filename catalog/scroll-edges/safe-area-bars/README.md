---
id: "safe-area-bars"
title: "Custom safe-area bars"
summary: "Give custom controls the system\u2019s scroll edge treatment."
category: "Scroll edges"
family: "Safe areas"
order: 704
kind: "native"
demoMinIOS: "26.0"
swiftFile: "SafeAreaBarsDemo.swift"
view: "SafeAreaBarsDemo"
captureNavigation: true
captureStyle: "screen"
apis: ["safeAreaBar", "scrollEdgeEffectStyle"]
tags: ["custom controls", "top bar", "bottom bar"]
---

# Custom safe-area bars

A safe-area bar reserves space for custom controls and extends nearby scroll edge effects to keep those controls legible.

## SwiftUI

```swift
import SwiftUI

@available(iOS 26.0, *)
struct CustomScrollBar: View {
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(1...30, id: \.self) { Text("Session \($0)").padding() }
            }.frame(maxWidth: .infinity)
        }
        .safeAreaBar(edge: .bottom) {
            Button("Play", systemImage: "play.fill") { }
                .buttonStyle(.glass).padding()
        }
    }
}
```

## Captures

<!-- captures:start -->
<!-- captures:end -->

## Full example

[Open the complete runnable example](SafeAreaBarsDemo.swift).

## Reference

[Apple: safeAreaBar](https://developer.apple.com/documentation/swiftui/view/safeareabar(edge:alignment:spacing:content:)).

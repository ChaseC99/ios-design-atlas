---
id: "adaptive-content-density"
title: "A grid that uses the window"
summary: "Fit more columns while keeping each card readable."
category: "Wide layouts"
family: "Adaptive workspaces"
order: 2302
kind: "native"
demoMinIOS: "18.0"
swiftFile: "AdaptiveContentDensityDemo.swift"
view: "AdaptiveContentDensityDemo"
captureNavigation: true
ownsNavigation: false
captureStyle: "screen"
apis: ["LazyVGrid", "GridItem", "ViewThatFits"]
tags: ["resizing", "density", "readable width"]
---

# A grid that uses the window

Adaptive grid columns respond to the available width, while a content-width limit keeps cards and reading surfaces from stretching across a large window.

## SwiftUI

```swift
import SwiftUI

struct FlexibleCardGrid: View {
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 180), spacing: 16)]) {
                ForEach(1...12, id: \.self) { number in
                    Text("Collection \(number)")
                        .frame(maxWidth: .infinity, minHeight: 140)
                        .background(.teal.opacity(0.12), in: .rect(cornerRadius: 20))
                }
            }.padding().frame(maxWidth: 1100).frame(maxWidth: .infinity)
        }
    }
}
```

## Captures

<!-- captures:start -->
<!-- captures:end -->

## Full example

[Open the complete runnable example](AdaptiveContentDensityDemo.swift).

## Reference

[Apple: LazyVGrid](https://developer.apple.com/documentation/swiftui/lazyvgrid).

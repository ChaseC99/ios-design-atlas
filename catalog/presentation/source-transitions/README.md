---
id: "source-transitions"
title: "Source-linked transitions"
summary: "A presentation with a visible origin."
category: "Presentation"
family: "Transitions"
order: 8
kind: "native"
demoMinIOS: "18.0"
swiftFile: "SourceTransitionsDemo.swift"
view: "SourceTransitionsDemo"
apis: ["matchedTransitionSource", "navigationTransition", "sheet"]
tags: ["animation", "zoom", "source"]
captureNavigation: false
captureStyle: "screen"
---

# Source-linked transitions

A source-linked zoom connects a presented destination to the view that opened it; run the example to see the motion.

## SwiftUI

```swift
import SwiftUI

struct ZoomPresentation: View {
    @Namespace private var transition
    @State private var showing = false
    var body: some View {
        Button("Open reference") { showing = true }
            .matchedTransitionSource(id: "reference", in: transition)
            .sheet(isPresented: $showing) {
                Text("Presentation study")
                    .navigationTransition(
                        .zoom(sourceID: "reference", in: transition)
                    )
            }
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 18 Pro · iOS 27.0

default. light appearance; Large text; en_US.

![Source-linked transitions on iPhone 18 Pro, iOS 27.0](captures/ios-27-0-iphone-18-pro-default-1792763067.649.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](SourceTransitionsDemo.swift).

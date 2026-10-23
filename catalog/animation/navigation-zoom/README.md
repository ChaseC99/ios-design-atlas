---
id: "navigation-zoom"
title: "Navigation zoom"
summary: "Connect a pushed destination to its source."
category: "Animation"
family: "Transitions"
order: 1808
kind: "native"
demoMinIOS: "18.0"
swiftFile: "NavigationZoomDemo.swift"
view: "NavigationZoomDemo"
apis: ["matchedTransitionSource", "navigationTransition", "NavigationStack"]
tags: ["zoom", "navigation", "source", "reduce-motion"]
captureNavigation: false
captureStyle: "screen"
ownsNavigation: true
captureAction: "tap"
---

# Navigation zoom

A navigation zoom transition connects a pushed destination to the view that opened it. The source identifier and namespace must match, and the default navigation transition is used for reduced motion here; captures document the destination rather than the animation.

## SwiftUI

```swift
import SwiftUI

struct NavigationZoomRecipe: View {
    @Namespace private var transition
    @State private var showsDetail = false
    var body: some View {
        NavigationStack {
            Button("Coastal path") { showsDetail = true }
                .matchedTransitionSource(id: "coast", in: transition)
                .navigationDestination(isPresented: $showsDetail) {
                    Text("The coastal path").font(.largeTitle)
                        .navigationTransition(.zoom(sourceID: "coast", in: transition))
                }
        }
    }
}
```

## Captures

<!-- captures:start -->
Captures have not been recorded yet.
<!-- captures:end -->

## Full example

[Open the complete runnable example](NavigationZoomDemo.swift).

## Reference

[Apple: motion](https://developer.apple.com/design/human-interface-guidelines/motion).

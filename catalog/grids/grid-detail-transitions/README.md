---
id: "grid-detail-transitions"
title: "Grid-to-detail transitions"
summary: "A matched source connects a selected grid item to its destination with a native zoom transition."
category: "Grids"
family: "Grids"
order: 1005
kind: "native"
demoMinIOS: "18.0"
swiftFile: "GridDetailTransitionsDemo.swift"
view: "GridDetailTransitionsDemo"
captureNavigation: true
ownsNavigation: false
apis: ["matchedTransitionSource", "navigationTransition", "NavigationLink"]
tags: ["zoom", "detail", "source", "iOS 18"]
---

# Grid-to-detail transitions

A matched source connects a selected grid item to its destination with a native zoom transition.

## SwiftUI

```swift
import SwiftUI

struct ZoomingGrid: View {
    @Namespace private var namespace

    var body: some View {
        NavigationStack {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
                ForEach(0..<6) { id in
                    NavigationLink {
                        Text("Artwork \(id + 1)")
                            .navigationTransition(.zoom(sourceID: id, in: namespace))
                    } label: {
                        Image(systemName: "sun.horizon")
                            .frame(maxWidth: .infinity).frame(height: 150)
                            .background(.orange.opacity(0.2), in: .rect(cornerRadius: 20))
                            .matchedTransitionSource(id: id, in: namespace)
                    }
                }
            }
            .padding()
        }
    }
}
```

## Captures

<!-- captures:start -->
<!-- captures:end -->

## Full example

[Open the complete runnable example](GridDetailTransitionsDemo.swift).

## Reference

[Apple: matchedTransitionSource](https://developer.apple.com/documentation/swiftui/view/matchedtransitionsource(id:in:configuration:)).

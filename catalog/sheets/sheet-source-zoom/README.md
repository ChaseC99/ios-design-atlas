---
id: "sheet-source-zoom"
title: "Sheets from a source view"
summary: "Connect a presentation to the item that opened it."
category: "Sheets"
family: "Transitions"
order: 111
kind: "native"
demoMinIOS: "18.0"
swiftFile: "SheetSourceZoomDemo.swift"
view: "SheetSourceZoomDemo"
apis: ["matchedTransitionSource", "navigationTransition", "Namespace"]
tags: ["zoom", "source", "animation"]
captureNavigation: false
captureStyle: "screen"
---

# Sheets from a source view

A zoom navigation transition connects a sheet to a visible source view. Matching the source identifier and namespace lets the system animate between the selected item and its presentation, including interactive dismissal.

## SwiftUI

```swift
import SwiftUI

struct SheetZoomRecipe: View {
    @Namespace private var transition
    @State private var isPresented = false

    var body: some View {
        Button("Coastal path") { isPresented = true }
            .matchedTransitionSource(id: "coast", in: transition)
            .sheet(isPresented: $isPresented) {
                Text("The coastal path").font(.largeTitle).padding()
                    .navigationTransition(.zoom(sourceID: "coast", in: transition))
            }
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Sheets from a source view on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792762494.454.png)

### iPhone 18 Pro · iOS 27.0

default. light appearance; Large text; en_US.

![Sheets from a source view on iPhone 18 Pro, iOS 27.0](captures/ios-27-0-iphone-18-pro-default-1792763049.387.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](SheetSourceZoomDemo.swift).

## Reference

[Apple: sheets](https://developer.apple.com/design/human-interface-guidelines/sheets).

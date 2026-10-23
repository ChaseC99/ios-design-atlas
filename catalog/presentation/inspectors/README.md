---
id: "inspectors"
title: "Adaptive inspectors"
summary: "Attributes alongside the selected content."
category: "Presentation"
family: "Inspectors"
order: 7
kind: "native"
demoMinIOS: "18.0"
swiftFile: "InspectorsDemo.swift"
view: "InspectorsDemo"
apis: ["inspector", "inspectorColumnWidth", "presentationDetents"]
tags: ["adaptive", "column", "editing"]
captureNavigation: false
captureStyle: "screen"
---

# Adaptive inspectors

An inspector shows properties of the selected content, adapting from a trailing column to a sheet when space is limited.

## SwiftUI

```swift
import SwiftUI

struct DocumentInspector: View {
    @State private var showing = false
    @State private var title = "Morning light"
    var body: some View {
        Button("Inspect document") { showing = true }
            .inspector(isPresented: $showing) {
                Form { TextField("Title", text: $title) }
                    .inspectorColumnWidth(min: 280, ideal: 320, max: 400)
                    .presentationDetents([.medium, .large])
            }
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 18 Pro · iOS 27.0

default. light appearance; Large text; en_US.

![Adaptive inspectors on iPhone 18 Pro, iOS 27.0](captures/ios-27-0-iphone-18-pro-default-1792762747.27.png)

### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Adaptive inspectors on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792765944.852.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Adaptive inspectors on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792765706.965.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](InspectorsDemo.swift).

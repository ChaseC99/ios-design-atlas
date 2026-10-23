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
<!-- captures:end -->

## Full example

[Open the complete runnable example](InspectorsDemo.swift).

---
id: "presentation-stress-tests"
title: "Long text & accessibility"
summary: "Make room for the less convenient cases."
category: "Presentation"
family: "Accessibility"
order: 9
kind: "native"
demoMinIOS: "18.0"
swiftFile: "PresentationStressTestsDemo.swift"
view: "PresentationStressTestsDemo"
apis: ["alert", "DynamicTypeSize", "ButtonRole"]
tags: ["dynamic-type", "localization", "long-text"]
captureNavigation: false
captureStyle: "screen"
---

# Long text & accessibility

Long messages and translated action labels reveal how alerts reflow as content and text size change.

## SwiftUI

```swift
import SwiftUI

struct LongMessageAlert: View {
    @State private var showing = false
    var body: some View {
        Button("Review changes") { showing = true }
            .alert("Save changes to this shared collection?",
                   isPresented: $showing) {
                Button("Save Changes") { /* Save. */ }
                Button("Discard Changes", role: .destructive) { /* Discard. */ }
                Button("Keep Editing", role: .cancel) { }
            } message: {
                Text("You changed the name, description, and order. "
                     + "Save to keep your changes for the next time you open it.")
            }
    }
}
```

## Captures

<!-- captures:start -->
<!-- captures:end -->

## Full example

[Open the complete runnable example](PresentationStressTestsDemo.swift).

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
captureReadyLabel: "Save Changes"
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
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Long text & accessibility on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792764290.467.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Long text & accessibility on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792763828.546.png)

### iPhone 18 Pro · iOS 27.0

default. light appearance; Large text; en_US.

![Long text & accessibility on iPhone 18 Pro, iOS 27.0](captures/ios-27-0-iphone-18-pro-default-1792764081.166.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](PresentationStressTestsDemo.swift).

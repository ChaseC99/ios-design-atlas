---
id: "safe-area-actions"
title: "Persistent action areas"
summary: "Keep an action visible without covering the last row."
category: "Scroll edges"
family: "Safe areas"
order: 703
kind: "native"
demoMinIOS: "18.0"
swiftFile: "SafeAreaActionsDemo.swift"
view: "SafeAreaActionsDemo"
captureNavigation: true
captureStyle: "screen"
apis: ["safeAreaInset"]
tags: ["bottom actions", "nested insets", "home indicator"]
---

# Persistent action areas

A safe-area inset reserves room for a persistent control so scrollable content remains reachable above it.

## SwiftUI

```swift
import SwiftUI

struct PersistentAction: View {
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(1...30, id: \.self) { Text("Stop \($0)").padding() }
            }.frame(maxWidth: .infinity)
        }
        .safeAreaInset(edge: .bottom) {
            Button("Save itinerary") { }
                .buttonStyle(.borderedProminent)
                .frame(maxWidth: .infinity)
                .padding().background(.bar)
        }
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 18 Pro · iOS 27.0

default. light appearance; Large text; en_US.

![Persistent action areas on iPhone 18 Pro, iOS 27.0](captures/ios-27-0-iphone-18-pro-default-1792762900.899.png)

### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Persistent action areas on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792766521.505.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Persistent action areas on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792766253.908.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](SafeAreaActionsDemo.swift).

## Reference

[Apple: safeAreaInset](https://developer.apple.com/documentation/swiftui/view/safeareainset(edge:alignment:spacing:content:)).

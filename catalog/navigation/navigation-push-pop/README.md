---
id: "navigation-push-pop"
title: "Push and pop"
summary: "A stack of destinations with a native back button."
category: "Navigation"
family: "Stacks"
order: 301
kind: "native"
demoMinIOS: "18.0"
swiftFile: "NavigationPushPopDemo.swift"
view: "NavigationPushPopDemo"
captureNavigation: false
ownsNavigation: true
apis: ["NavigationStack", "NavigationLink", "dismiss"]
tags: ["push", "pop", "back button", "gesture"]
---

# Push and pop

A stack of destinations with a native back button.

## SwiftUI

```swift
import SwiftUI

struct JourneyNavigation: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("Coastal walks", value: "Coastal walks")
            }
            .navigationTitle("Journeys")
            .navigationDestination(for: String.self) { title in
                Text(title)
                    .navigationTitle(title)
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 18 Pro · iOS 27.0

default. light appearance; Large text; en_US.

![Push and pop on iPhone 18 Pro, iOS 27.0](captures/ios-27-0-iphone-18-pro-default-1792762820.158.png)

### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Push and pop on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792766218.655.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Push and pop on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792766036.794.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](NavigationPushPopDemo.swift).

## Reference

[Apple: NavigationStack](https://developer.apple.com/documentation/swiftui/navigationstack).

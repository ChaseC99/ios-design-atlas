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
<!-- captures:end -->

## Full example

[Open the complete runnable example](NavigationPushPopDemo.swift).

## Reference

[Apple: NavigationStack](https://developer.apple.com/documentation/swiftui/navigationstack).

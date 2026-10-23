---
id: "partial-and-offline"
title: "Partial failures and offline content"
summary: "Keep saved content useful when one part fails."
category: "States"
family: "Degraded states"
order: 2405
kind: "native"
demoMinIOS: "18.0"
swiftFile: "PartialOfflineDemo.swift"
view: "PartialOfflineDemo"
apis: ["List", "LabeledContent", "ProgressView", "Task"]
tags: ["partial-failure", "offline", "stale", "cached-content", "retry"]
captureNavigation: true
captureStyle: "screen"
---

# Partial failures and offline content

A partial failure belongs beside the item that failed, while an offline indicator can explain why saved content is stale. Keep readable content available, disable only operations that require connectivity, and retry failed items independently. Connectivity and results here are controlled local fixtures.

## SwiftUI

```swift
import SwiftUI

struct OfflineRecipe: View {
    @State private var offline = true
    @State private var repaired = false
    var body: some View {
        List {
            if offline { Label("Offline · Showing saved places", systemImage: "wifi.slash") }
            Text("Harbor walk")
            Text("Forest trail")
            HStack {
                Label(repaired ? "Mountain lookout" : "Mountain details unavailable", systemImage: repaired ? "mountain.2" : "exclamationmark.circle")
                Spacer()
                if !repaired { Button("Retry") { repaired = true }.disabled(offline) }
            }
            Toggle("Offline", isOn: $offline)
        }
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Partial failures and offline content on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792770867.259.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](PartialOfflineDemo.swift).

## Reference

[Apple: loading](https://developer.apple.com/design/human-interface-guidelines/loading).

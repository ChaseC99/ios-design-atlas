---
id: "recoverable-errors"
title: "Recoverable errors and retry"
summary: "Turn a failed local load into a clear next action."
category: "States"
family: "Recovery"
order: 2404
kind: "native"
demoMinIOS: "18.0"
swiftFile: "RecoverableErrorsDemo.swift"
view: "RecoverableErrorsDemo"
apis: ["ContentUnavailableView", "ProgressView", "Task"]
tags: ["error", "retry", "cancellation", "state-machine"]
captureNavigation: true
captureStyle: "screen"
---

# Recoverable errors and retry

A recoverable error explains what failed, preserves a clear retry action, and prevents duplicate work while retrying. This deterministic local state machine can succeed or fail after a short delay, and cancellation returns to an actionable state without delivering a late result.

## SwiftUI

```swift
import SwiftUI

struct RetryRecipe: View {
    @State private var loaded = false
    @State private var retrying = false
    var body: some View {
        Group {
            if loaded { Text("Collection ready") }
            else {
                ContentUnavailableView {
                    Label("Couldn’t load collection", systemImage: "exclamationmark.icloud")
                } actions: {
                    Button(retrying ? "Retrying…" : "Retry") { retrying = true }.disabled(retrying)
                }
            }
        }
        .task(id: retrying) {
            guard retrying else { return }
            do { try await Task.sleep(for: .seconds(1)) } catch { return }
            loaded = true; retrying = false
        }
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Recoverable errors and retry on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792770915.581.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](RecoverableErrorsDemo.swift).

## Reference

[Apple: loading](https://developer.apple.com/design/human-interface-guidelines/loading).

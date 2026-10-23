---
id: "optimistic-updates"
title: "Optimistic updates and rollback"
summary: "Show a change immediately and reconcile its result."
category: "States"
family: "Recovery"
order: 2407
kind: "native"
demoMinIOS: "18.0"
swiftFile: "OptimisticUpdatesDemo.swift"
view: "OptimisticUpdatesDemo"
apis: ["Task", "Button", "ProgressView"]
tags: ["optimistic-update", "rollback", "retry", "cancellation", "state-machine"]
captureNavigation: true
captureStyle: "screen"
---

# Optimistic updates and rollback

An optimistic update changes the local interface immediately, then confirms or rolls back that change when work finishes. Keep the last confirmed value, prevent conflicting submissions, and make cancellation restore it too. A local failure switch makes both outcomes repeatable without a server.

## SwiftUI

```swift
import SwiftUI

struct OptimisticRecipe: View {
    @State private var favorite = false
    @State private var confirmed = false
    @State private var pending = false
    @State private var shouldFail = true
    var body: some View {
        VStack(spacing: 20) {
            Button(favorite ? "Remove favorite" : "Favorite") { favorite.toggle(); pending = true }
                .disabled(pending)
            Toggle("Simulate failure", isOn: $shouldFail).disabled(pending)
            if pending { ProgressView("Saving…") }
        }
        .task(id: pending) {
            guard pending else { return }
            do { try await Task.sleep(for: .seconds(1)) }
            catch { favorite = confirmed; pending = false; return }
            if shouldFail { favorite = confirmed } else { confirmed = favorite }
            pending = false
        }
    }
}
```

## Captures

<!-- captures:start -->
Captures have not been recorded yet.
<!-- captures:end -->

## Full example

[Open the complete runnable example](OptimisticUpdatesDemo.swift).

## Reference

[Apple: loading](https://developer.apple.com/design/human-interface-guidelines/loading).

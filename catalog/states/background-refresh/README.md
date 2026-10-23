---
id: "background-refresh"
title: "Refreshing existing content"
summary: "Update stable rows while the collection stays visible."
category: "States"
family: "Loading"
order: 2406
kind: "native"
demoMinIOS: "18.0"
swiftFile: "BackgroundRefreshDemo.swift"
view: "BackgroundRefreshDemo"
apis: ["refreshable", "List", "Task", "ProgressView"]
tags: ["background-refresh", "pull-to-refresh", "stable-identity", "stale", "cancellation"]
captureNavigation: true
captureStyle: "screen"
---

# Refreshing existing content

Refresh existing content in place so a background update does not replace a usable screen with a loader. Stable row identifiers and reserved text space keep this local refresh from rebuilding or shifting the collection; both pull-to-refresh and an explicit button run the same cancellable task.

## SwiftUI

```swift
import SwiftUI

struct RefreshRecipe: View {
    @State private var updated = false
    var body: some View {
        List(["Harbor", "Forest", "Mountain"], id: \.self) { name in
            VStack(alignment: .leading) {
                Text(name).font(.headline)
                Text(updated ? "Updated just now" : "Saved yesterday").font(.caption).foregroundStyle(.secondary)
            }
        }
        .refreshable {
            do { try await Task.sleep(for: .seconds(1)) } catch { return }
            updated = true
        }
    }
}
```

## Captures

<!-- captures:start -->
Captures have not been recorded yet.
<!-- captures:end -->

## Full example

[Open the complete runnable example](BackgroundRefreshDemo.swift).

## Reference

[Apple: loading](https://developer.apple.com/design/human-interface-guidelines/loading).

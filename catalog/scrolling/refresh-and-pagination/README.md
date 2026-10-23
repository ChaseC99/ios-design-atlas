---
id: "refresh-and-pagination"
title: "Refresh and pagination"
summary: "Refresh a collection and load the next page as its end approaches."
category: "Scrolling"
family: "Loading"
order: 607
kind: "native"
demoMinIOS: "18.0"
swiftFile: "RefreshPaginationDemo.swift"
view: "RefreshPaginationDemo"
captureNavigation: true
ownsNavigation: false
captureStyle: "screen"
apis: ["refreshable", "task"]
tags: ["refresh", "pagination", "loading", "cancellation"]
---

# Refresh and pagination

Pull-to-refresh and a lazy end marker can load data incrementally; this example uses delayed local fixtures so it works offline.

## SwiftUI

```swift
import SwiftUI

struct RefreshableList: View {
    @State private var revision = 0
    var body: some View {
        List(1...20, id: \.self) { number in
            Text("Study \(number) · revision \(revision)")
        }
        .refreshable {
            do { try await Task.sleep(for: .milliseconds(500)) }
            catch { return }
            revision += 1
        }
    }
}
```

## Captures

<!-- captures:start -->
<!-- captures:end -->

## Full example

[Open the complete runnable example](RefreshPaginationDemo.swift).

## Reference

[Apple: refreshable](https://developer.apple.com/documentation/swiftui/view/refreshable(action:)).

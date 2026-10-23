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
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Refresh and pagination on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792766477.394.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Refresh and pagination on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792766203.705.png)

### iPhone 18 Pro · iOS 27.0

default. light appearance; Large text; en_US.

![Refresh and pagination on iPhone 18 Pro, iOS 27.0](captures/ios-27-0-iphone-18-pro-default-1792768349.074.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](RefreshPaginationDemo.swift).

## Reference

[Apple: refreshable](https://developer.apple.com/documentation/swiftui/view/refreshable(action:)).

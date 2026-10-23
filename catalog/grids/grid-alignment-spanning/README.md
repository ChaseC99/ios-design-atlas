---
id: "grid-alignment-spanning"
title: "Grid alignment and spans"
summary: "A regular grid aligns rows and columns while selected cells span the whole arrangement."
category: "Grids"
family: "Grids"
order: 1002
kind: "native"
demoMinIOS: "18.0"
swiftFile: "GridAlignmentSpanningDemo.swift"
view: "GridAlignmentSpanningDemo"
captureNavigation: true
ownsNavigation: false
apis: ["Grid", "GridRow", "gridCellColumns", "gridColumnAlignment", "gridCellUnsizedAxes"]
tags: ["alignment", "spanning", "spacing", "dashboard"]
---

# Grid alignment and spans

A regular grid aligns rows and columns while selected cells span the whole arrangement.

## SwiftUI

```swift
import SwiftUI

struct SpanningGrid: View {
    var body: some View {
        Grid(horizontalSpacing: 24, verticalSpacing: 16) {
            Text("This week").font(.title2).gridCellColumns(2)
            Divider().gridCellColumns(2).gridCellUnsizedAxes(.horizontal)
            GridRow {
                Text("Distance").gridColumnAlignment(.leading)
                Text("11.6 km").gridColumnAlignment(.trailing)
            }
            GridRow {
                Text("Time outside")
                Text("145 min")
            }
        }
        .padding()
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Grid alignment and spans on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792765889.672.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Grid alignment and spans on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792765659.359.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](GridAlignmentSpanningDemo.swift).

## Reference

[Apple: Grid](https://developer.apple.com/documentation/swiftui/grid).

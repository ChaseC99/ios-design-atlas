---
id: "chart-mark-types"
title: "Chart marks and axes"
summary: "Bar, line, area, and point marks present the same data with different emphasis."
category: "Charts"
family: "Charts"
order: 2801
kind: "native"
demoMinIOS: "18.0"
swiftFile: "ChartMarkTypesDemo.swift"
view: "ChartMarkTypesDemo"
captureNavigation: true
ownsNavigation: false
apis: ["Chart", "BarMark", "LineMark", "AreaMark", "PointMark", "RuleMark", "AxisMarks"]
tags: ["charts", "bar", "line", "area", "point", "axes", "annotations"]
---

# Chart marks and axes

Bar, line, area, and point marks present the same data with different emphasis.

## SwiftUI

```swift
import SwiftUI
import Charts

struct WeeklyBarChart: View {
    let minutes = [32, 48, 41, 64, 52, 77, 58]
    var body: some View {
        Chart {
            ForEach(minutes.indices, id: \.self) { day in
                BarMark(x: .value("Day", day + 1), y: .value("Minutes", minutes[day]))
            }
            RuleMark(y: .value("Goal", 60))
                .lineStyle(StrokeStyle(dash: [4, 4]))
                .annotation(position: .top) { Text("Goal").font(.caption) }
        }
        .foregroundStyle(.teal)
        .chartYScale(domain: 0...90)
        .frame(height: 240)
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Chart marks and axes on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792770549.55.png)
<!-- captures:end -->

## Example notes

The chart uses fixed, fictional sample data. VoiceOver and direct manipulation still require manual device review.

## Full example

[Open the complete runnable example](ChartMarkTypesDemo.swift).

## Reference

[Apple: Chart](https://developer.apple.com/documentation/charts/chart).

---
id: "chart-data-edge-cases"
title: "Chart data edge cases"
summary: "Empty, missing, negative, and extreme values need deliberate domains and honest gaps."
category: "Charts"
family: "Charts"
order: 2806
kind: "native"
demoMinIOS: "18.0"
swiftFile: "ChartDataEdgeCasesDemo.swift"
view: "ChartDataEdgeCasesDemo"
captureNavigation: true
ownsNavigation: false
apis: ["Chart", "LineMark", "PointMark", "RuleMark", "chartYScale", "ContentUnavailableView"]
tags: ["empty data", "missing data", "sparse data", "negative values", "scale"]
---

# Chart data edge cases

Empty, missing, negative, and extreme values need deliberate domains and honest gaps.

## SwiftUI

```swift
import SwiftUI
import Charts

struct GappedLineChart: View {
    let values: [Double?] = [4, 6, nil, nil, 8, 7, 9]
    var body: some View {
        Chart {
            ForEach(values.indices, id: \.self) { day in
                if let value = values[day] {
                    let segment = values.prefix(day).filter { $0 == nil }.count
                    LineMark(x: .value("Day", day), y: .value("Value", value),
                             series: .value("Segment", segment))
                    PointMark(x: .value("Day", day), y: .value("Value", value))
                }
            }
        }
        .frame(height: 240)
    }
}
```

## Captures

<!-- captures:start -->
<!-- captures:end -->

## Example notes

The chart uses fixed, fictional sample data. VoiceOver and direct manipulation still require manual device review.

## Full example

[Open the complete runnable example](ChartDataEdgeCasesDemo.swift).

## Reference

[Apple: Chart](https://developer.apple.com/documentation/charts/chart).

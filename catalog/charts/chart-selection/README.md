---
id: "chart-selection"
title: "Chart selection and scrubbing"
summary: "Native chart selection maps a gesture to a domain value that drives a visible annotation."
category: "Charts"
family: "Charts"
order: 2802
kind: "native"
demoMinIOS: "18.0"
swiftFile: "ChartSelectionDemo.swift"
view: "ChartSelectionDemo"
captureNavigation: true
ownsNavigation: false
apis: ["Chart", "chartXSelection", "RuleMark", "PointMark", "annotation"]
tags: ["selection", "scrubbing", "annotations", "line chart"]
---

# Chart selection and scrubbing

Native chart selection maps a gesture to a domain value that drives a visible annotation.

## SwiftUI

```swift
import SwiftUI
import Charts

struct SelectedReadingChart: View {
    @State private var selectedDay: Int? = 3
    let values = [20, 24, 21, 28, 25]
    var body: some View {
        Chart {
            ForEach(values.indices, id: \.self) { day in
                LineMark(x: .value("Day", day), y: .value("Value", values[day]))
            }
            if let day = selectedDay, values.indices.contains(day) {
                RuleMark(x: .value("Day", day))
                    .annotation(position: .top) { Text("\(values[day])") }
            }
        }
        .chartXSelection(value: $selectedDay)
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

[Open the complete runnable example](ChartSelectionDemo.swift).

## Reference

[Apple: Chart](https://developer.apple.com/documentation/charts/chart).

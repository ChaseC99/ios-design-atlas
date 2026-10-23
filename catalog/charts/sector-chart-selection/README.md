---
id: "sector-chart-selection"
title: "Sector and donut charts"
summary: "Sector marks show parts of a whole and expose their selected angular value."
category: "Charts"
family: "Charts"
order: 2803
kind: "native"
demoMinIOS: "18.0"
swiftFile: "SectorChartSelectionDemo.swift"
view: "SectorChartSelectionDemo"
captureNavigation: true
ownsNavigation: false
apis: ["Chart", "SectorMark", "chartAngleSelection", "chartForegroundStyleScale"]
tags: ["pie chart", "donut chart", "sector", "selection", "legend"]
---

# Sector and donut charts

Sector marks show parts of a whole and expose their selected angular value.

## SwiftUI

```swift
import SwiftUI
import Charts

struct SelectableDonut: View {
    @State private var selectedAngle: Double?
    let values: [Double] = [160, 95, 65, 40]
    var body: some View {
        Chart(values.indices, id: \.self) { index in
            SectorMark(angle: .value("Minutes", values[index]), innerRadius: .ratio(0.65), angularInset: 2)
                .foregroundStyle(by: .value("Activity", index))
        }
        .chartAngleSelection(value: $selectedAngle)
        .frame(height: 260)
    }
}
```

## Captures

<!-- captures:start -->
<!-- captures:end -->

## Example notes

The chart uses fixed, fictional sample data. VoiceOver and direct manipulation still require manual device review.

## Full example

[Open the complete runnable example](SectorChartSelectionDemo.swift).

## Reference

[Apple: Chart](https://developer.apple.com/documentation/charts/chart).

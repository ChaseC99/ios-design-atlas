---
id: "three-dimensional-charts"
title: "Three-dimensional charts"
summary: "Chart3D plots three numeric dimensions and lets the viewer rotate the native chart."
category: "Charts"
family: "Charts"
order: 2809
kind: "native"
demoMinIOS: "26.0"
swiftFile: "ThreeDimensionalChartsDemo.swift"
view: "ThreeDimensionalChartsDemo"
captureNavigation: true
ownsNavigation: false
apis: ["Chart3D", "PointMark", "chart3DPose", "chartZScale"]
tags: ["3D charts", "scatter plot", "pose", "iOS 26"]
---

# Three-dimensional charts

Chart3D plots three numeric dimensions and lets the viewer rotate the native chart.

## SwiftUI

```swift
import SwiftUI
import Charts

@available(iOS 26.0, *)
struct TrailScatterPlot: View {
    @State private var pose: Chart3DPose = .default
    var body: some View {
        Chart3D {
            PointMark(x: .value("Distance", 3.2), y: .value("Climb", 90), z: .value("Hours", 0.9))
            PointMark(x: .value("Distance", 6.8), y: .value("Climb", 480), z: .value("Hours", 2.5))
            PointMark(x: .value("Distance", 12.0), y: .value("Climb", 980), z: .value("Hours", 5.2))
        }
        .chart3DPose($pose)
        .frame(height: 320)
    }
}
```

## Captures

<!-- captures:start -->
<!-- captures:end -->

## Example notes

Chart3D is native starting in iOS 26. The six trails are fictional fixtures, not route guidance. The chart remains rotatable; Front, Top, and Reset supply alternative viewpoints. The text rows provide exact values. Gesture and VoiceOver review remains pending.

## Full example

[Open the complete runnable example](ThreeDimensionalChartsDemo.swift).

## Reference

[Apple: Chart3D](https://developer.apple.com/documentation/charts/chart3d).

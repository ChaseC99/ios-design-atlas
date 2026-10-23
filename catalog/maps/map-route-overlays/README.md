---
id: "map-route-overlays"
title: "Paths and region overlays"
summary: "Layer an illustrative route and shaded area on the map."
category: "Maps"
family: "Map overlays"
order: 2703
kind: "native"
demoMinIOS: "18.0"
swiftFile: "MapRouteOverlaysDemo.swift"
view: "MapRouteOverlaysDemo"
captureNavigation: true
ownsNavigation: false
captureStyle: "screen"
apis: ["MapPolyline", "MapPolygon", "MapCameraPosition"]
tags: ["route", "overlay", "sample data"]
---

# Paths and region overlays

Polyline and polygon overlays visualize supplied coordinates; this hand-authored example is an illustrative path, not a calculated route or navigation advice.

## SwiftUI

```swift
import SwiftUI
import MapKit

struct SuppliedPath: View {
    private let coordinates = [CLLocationCoordinate2D(latitude: 37.8063, longitude: -122.4692), CLLocationCoordinate2D(latitude: 37.7987, longitude: -122.4547)]
    var body: some View {
        Map {
            MapPolyline(coordinates: coordinates)
                .stroke(.teal, style: StrokeStyle(lineWidth: 5, lineCap: .round))
        }
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Paths and region overlays on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792770770.249.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](MapRouteOverlaysDemo.swift).

## Reference

[Apple: MapPolyline](https://developer.apple.com/documentation/mapkit/mappolyline).

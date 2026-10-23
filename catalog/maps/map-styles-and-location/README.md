---
id: "map-styles-and-location"
title: "Map styles and location access"
summary: "Change the map\u2019s appearance and request location explicitly."
category: "Maps"
family: "Map foundations"
order: 2701
kind: "native"
demoMinIOS: "18.0"
swiftFile: "MapStylesLocationDemo.swift"
view: "MapStylesLocationDemo"
captureNavigation: true
ownsNavigation: false
captureStyle: "screen"
apis: ["Map", "MapStyle", "CLLocationManager"]
tags: ["camera", "location permission", "map controls"]
---

# Map styles and location access

A fixed sample region supports map-style comparisons; locating the user is a separate action that requires app configuration, permission, and a location fix.

## SwiftUI

```swift
import SwiftUI
import MapKit

struct FixedMapRegion: View {
    @State private var position = MapCameraPosition.region(MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.8024, longitude: -122.455),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)))
    var body: some View {
        Map(position: $position)
            .mapStyle(.standard(elevation: .realistic))
            .mapControls { MapCompass(); MapPitchToggle(); MapScaleView() }
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Map styles and location access on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792770776.524.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](MapStylesLocationDemo.swift).

## Reference

[Apple: Map](https://developer.apple.com/documentation/mapkit/map).

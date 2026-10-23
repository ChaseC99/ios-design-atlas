---
id: "map-place-selection"
title: "Markers and selected place cards"
summary: "Keep the selected map marker and its detail card in sync."
category: "Maps"
family: "Map selection"
order: 2702
kind: "native"
demoMinIOS: "18.0"
swiftFile: "MapPlaceSelectionDemo.swift"
view: "MapPlaceSelectionDemo"
captureNavigation: true
ownsNavigation: false
captureStyle: "screen"
apis: ["Map(selection:)", "Marker", "Annotation"]
tags: ["selection", "place card", "markers"]
---

# Markers and selected place cards

Tagged map content drives a selected place card; these clearly labeled sample locations remain useful even when base-map imagery has not loaded.

## SwiftUI

```swift
import SwiftUI
import MapKit

struct SelectedMarker: View {
    @State private var selected: String?
    var body: some View {
        Map(selection: $selected) {
            Marker("Sample stop", coordinate: CLLocationCoordinate2D(latitude: 37.8064, longitude: -122.4702))
                .tag("stop")
        }
        .safeAreaInset(edge: .bottom) {
            if selected == "stop" { Text("Sample stop selected").padding().background(.regularMaterial) }
        }
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Markers and selected place cards on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792770764.187.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](MapPlaceSelectionDemo.swift).

## Reference

[Apple: Map(selection:)](https://developer.apple.com/documentation/mapkit/marker).

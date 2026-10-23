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
<!-- captures:end -->

## Full example

[Open the complete runnable example](MapPlaceSelectionDemo.swift).

## Reference

[Apple: Map(selection:)](https://developer.apple.com/documentation/mapkit/marker).

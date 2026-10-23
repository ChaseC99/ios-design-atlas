---
id: "map-movable-place-sheet"
title: "A map with a movable sheet"
summary: "Keep the map interactive behind a compact place sheet."
category: "Maps"
family: "Map presentations"
order: 2705
kind: "native"
demoMinIOS: "18.0"
swiftFile: "MapMovablePlaceSheetDemo.swift"
view: "MapMovablePlaceSheetDemo"
captureNavigation: true
ownsNavigation: false
captureStyle: "screen"
apis: ["presentationDetents", "presentationBackgroundInteraction", "Map"]
tags: ["sheet", "detents", "map gestures"]
---

# A map with a movable sheet

A place sheet uses multiple detents and leaves the background map interactive at its smaller heights; sample details remain available without map tiles.

## SwiftUI

```swift
import SwiftUI
import MapKit

struct MapAndSheet: View {
    @State private var presented = false
    var body: some View {
        Map {
            Marker("Sample place", coordinate: CLLocationCoordinate2D(latitude: 37.8064, longitude: -122.4702))
        }
        .overlay(alignment: .bottom) { Button("Details") { presented = true }.buttonStyle(.borderedProminent).padding() }
        .sheet(isPresented: $presented) {
            Text("Sample place details").padding()
                .presentationDetents([.height(250), .medium, .large])
                .presentationBackgroundInteraction(.enabled(upThrough: .medium))
        }
    }
}
```

## Captures

<!-- captures:start -->
<!-- captures:end -->

## Full example

[Open the complete runnable example](MapMovablePlaceSheetDemo.swift).

## Reference

[Apple: presentationDetents](https://developer.apple.com/documentation/swiftui/view/presentationbackgroundinteraction(_:)).

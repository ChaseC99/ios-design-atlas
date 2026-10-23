---
id: "hinge-observation"
title: "Live hinge observation"
summary: "Read the system\u2019s actual hinge angle and status."
category: "Device adaptation"
family: "iPhone Duo"
order: 2205
kind: "native"
demoMinIOS: "27.1"
swiftFile: "HingeObservationDemo.swift"
view: "HingeObservationDemo"
captureNavigation: true
ownsNavigation: false
captureStyle: "screen"
apis: ["onHingeChange", "DeviceHinge"]
tags: ["angle", "pose", "device requirements"]
---

# Live hinge observation

Hinge-change events expose the angle and system-classified status on supported hardware; this example never substitutes simulated hinge data.

These iOS 27.1 APIs are marked beta in Apple’s documentation and require iOS 27.1.

## SwiftUI

```swift
import SwiftUI

@available(iOS 27.1, *)
struct LiveHingeAngle: View {
    @State private var hinge: DeviceHinge?
    var body: some View {
        Group {
            if let hinge {
                Text(hinge.angle.degrees, format: .number.precision(.fractionLength(0)))
            } else {
                Text("No hinge data reported")
            }
        }
        .onHingeChange { _, context in hinge = context.hinge }
    }
}
```

## Captures

<!-- captures:start -->
### iPhone Duo · iOS 27.1

default. light appearance; Large text; en_US.

![Live hinge observation on iPhone Duo, iOS 27.1](captures/ios-27-1-atlas-iphone-duo-default-1792765928.559.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](HingeObservationDemo.swift).

## Reference

[Apple: onHingeChange](https://developer.apple.com/documentation/swiftui/devicehinge).

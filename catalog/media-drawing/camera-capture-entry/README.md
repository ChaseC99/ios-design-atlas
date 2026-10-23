---
id: "camera-capture-entry"
title: "A camera capture entry"
summary: "Open the system camera only after an explicit action."
category: "Media & drawing"
family: "Capture"
order: 2607
kind: "native"
demoMinIOS: "18.0"
swiftFile: "CameraCaptureEntryDemo.swift"
view: "CameraCaptureEntryDemo"
captureNavigation: true
ownsNavigation: false
captureStyle: "screen"
apis: ["UIImagePickerController", "AVCaptureDevice"]
tags: ["camera", "permission", "unavailable state"]
---

# A camera capture entry

The native camera requires a physical camera, authorization, and a usage description; unavailable hardware and denied access remain visible states.

## SwiftUI

```swift
import SwiftUI
import AVFoundation

struct CameraAvailability: View {
    @State private var message = "Camera idle"
    var body: some View {
        VStack {
            Button("Check camera access") {
                Task {
                    guard UIImagePickerController.isSourceTypeAvailable(.camera) else { message = "No camera available"; return }
                    guard Bundle.main.object(forInfoDictionaryKey: "NSCameraUsageDescription") is String else { message = "Camera access is not configured"; return }
                    let allowed = await AVCaptureDevice.requestAccess(for: .video)
                    message = allowed ? "Camera authorized" : "Camera unavailable"
                }
            }
            Text(message)
        }
    }
}
```

## Captures

<!-- captures:start -->
<!-- captures:end -->

## Full example

[Open the complete runnable example](CameraCaptureEntryDemo.swift).

## Reference

[Apple: UIImagePickerController](https://developer.apple.com/documentation/uikit/uiimagepickercontroller).

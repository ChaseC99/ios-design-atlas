---
id: "contextual-permissions"
title: "Permissions in context"
summary: "Read real access states and request only from a relevant action."
category: "Privacy"
family: "Permissions"
order: 3004
kind: "native"
demoMinIOS: "18.0"
swiftFile: "ContextualPermissionsDemo.swift"
view: "ContextualPermissionsDemo"
apis: ["AVCaptureDevice.requestAccess", "PHPhotoLibrary", "CLLocationManager", "UNUserNotificationCenter", "PhotosPicker"]
tags: ["camera", "microphone", "photos", "location", "notifications", "denied", "restricted", "limited", "settings"]
captureNavigation: true
captureStyle: "screen"
---

# Permissions in context

Permission requests should follow an action that needs the protected capability. This screen reads real access states, distinguishes denied, restricted, and limited access, and offers Settings recovery; request buttons check required usage descriptions first. The photo picker can select an item without broad library permission, and the example never reads its pixels, requests a location, records media, or schedules notifications.

## SwiftUI

```swift
import SwiftUI
import UserNotifications

struct NotificationPermissionRecipe: View {
    @State private var status = "Not requested by this example"
    var body: some View {
        VStack(spacing: 20) {
            Label("Reminders for saved plans", systemImage: "bell")
            Button("Allow notifications") {
                Task {
                    do {
                        let allowed = try await UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound])
                        status = allowed ? "Allowed" : "Not allowed; review access in Settings"
                    } catch { status = "Request failed" }
                }
            }
            Text(status).font(.caption)
        }.padding()
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Permissions in context on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792770588.812.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](ContextualPermissionsDemo.swift).

## Reference

[Apple: Privacy](https://developer.apple.com/design/human-interface-guidelines/privacy).

---
id: "biometrics-and-reauthentication"
title: "Biometrics and reauthentication"
summary: "Unlock a local sample with system authentication."
category: "Privacy"
family: "Authentication"
order: 3003
kind: "native"
demoMinIOS: "18.0"
swiftFile: "BiometricsReauthenticationDemo.swift"
view: "BiometricsReauthenticationDemo"
apis: ["LAContext", "canEvaluatePolicy", "evaluatePolicy", "invalidate"]
tags: ["face-id", "touch-id", "reauthentication", "session-expired", "cancellation", "setup-required"]
captureNavigation: true
captureStyle: "screen"
---

# Biometrics and reauthentication

LocalAuthentication presents the real device authentication interface and reports success, unavailability, cancellation, or failure. This sample gates access to a local card, can expire that local session, and invalidates interrupted requests. Face ID requires NSFaceIDUsageDescription; no authentication runs automatically or during capture.

## SwiftUI

```swift
import SwiftUI
import LocalAuthentication

struct BiometricRecipe: View {
    @State private var status = "Locked"
    var body: some View {
        VStack(spacing: 20) {
            Text(status)
            Button("Unlock sample") {
                guard !(Bundle.main.object(forInfoDictionaryKey: "NSFaceIDUsageDescription") as? String ?? "").isEmpty else {
                    status = "Add NSFaceIDUsageDescription to the app target"; return
                }
                Task {
                    let context = LAContext()
                    var error: NSError?
                    guard context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) else { status = "Device authentication unavailable"; return }
                    do { status = try await context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "Reveal the local sample.") ? "Unlocked" : "Not authenticated" }
                    catch { status = "Authentication cancelled or failed" }
                }
            }
        }.padding()
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Biometrics and reauthentication on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792770519.518.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](BiometricsReauthenticationDemo.swift).

## Reference

[Apple: LocalAuthentication](https://developer.apple.com/documentation/localauthentication).

---
id: "sign-in-with-apple"
title: "Sign in with Apple"
summary: "Use the native authentication button with an explicit setup gate."
category: "Privacy"
family: "Authentication"
order: 3001
kind: "native"
demoMinIOS: "18.0"
swiftFile: "AppleSignInDemo.swift"
view: "AppleSignInDemo"
apis: ["SignInWithAppleButton", "ASAuthorizationAppleIDRequest", "ASAuthorizationError"]
tags: ["apple-id", "authentication", "cancellation", "entitlement", "setup-required"]
captureNavigation: true
captureStyle: "screen"
---

# Sign in with Apple

SignInWithAppleButton supplies Apple’s native sign-in control and authorization callbacks. It is deliberately disabled in this catalog target until the signing capability is configured; the full example handles success, cancellation, and failure without displaying credentials. A production app must verify the returned credential with its backend before treating the person as signed in.

## SwiftUI

```swift
import SwiftUI
import AuthenticationServices

struct AppleSignInRecipe: View {
    private let capabilityConfigured = false // Enable only after configuring Sign in with Apple in the target.
    @State private var status = "Sign in with Apple capability required"
    var body: some View {
        VStack(spacing: 20) {
            SignInWithAppleButton(.signIn) { request in
                request.requestedScopes = []
            } onCompletion: { result in
                switch result {
                case .success: status = "Credential received; backend verification required"
                case .failure(let error): status = (error as? ASAuthorizationError)?.code == .canceled ? "Cancelled" : "Authorization failed"
                }
            }.frame(height: 50).disabled(!capabilityConfigured)
            Text(status).font(.caption)
        }.padding()
    }
}
```

## Captures

<!-- captures:start -->
Captures have not been recorded yet.
<!-- captures:end -->

## Full example

[Open the complete runnable example](AppleSignInDemo.swift).

## Reference

[Apple: Sign in with Apple entitlement](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.applesignin).

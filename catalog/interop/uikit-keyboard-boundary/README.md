---
id: "uikit-keyboard-boundary"
title: "Keyboard layout at a framework boundary"
summary: "A UIKit keyboard layout guide positions a native composer inside a SwiftUI-hosted controller."
category: "Versions & interop"
family: "Interoperability"
order: 3505
kind: "native"
demoMinIOS: "18.0"
swiftFile: "UIKitKeyboardBoundaryDemo.swift"
view: "UIKitKeyboardBoundaryDemo"
captureNavigation: true
ownsNavigation: false
apis: ["UIViewControllerRepresentable", "UIKeyboardLayoutGuide", "UITextField", "UIHostingController", "ignoresSafeArea"]
tags: ["keyboard", "safe area", "UIKit", "SwiftUI", "composer"]
captureKeyboard: true
---

# Keyboard layout at a framework boundary

A UIKit keyboard layout guide positions a native composer inside a SwiftUI-hosted controller.

## SwiftUI

```swift
import SwiftUI
import UIKit

struct KeyboardGuideComposer: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = UIViewController()
        let field = UITextField()
        field.borderStyle = .roundedRect; field.placeholder = "Message"
        field.translatesAutoresizingMaskIntoConstraints = false
        controller.view.addSubview(field)
        NSLayoutConstraint.activate([
            field.leadingAnchor.constraint(equalTo: controller.view.layoutMarginsGuide.leadingAnchor),
            field.trailingAnchor.constraint(equalTo: controller.view.layoutMarginsGuide.trailingAnchor),
            field.heightAnchor.constraint(equalToConstant: 44),
            field.bottomAnchor.constraint(equalTo: controller.view.keyboardLayoutGuide.topAnchor, constant: -12)
        ])
        return controller
    }
    func updateUIViewController(_ controller: UIViewController, context: Context) {}
}

struct KeyboardBoundaryExample: View {
    var body: some View { KeyboardGuideComposer().ignoresSafeArea(.keyboard) }
}
```

## Captures

<!-- captures:start -->
<!-- captures:end -->

## Example notes

The outer SwiftUI view opts out of keyboard safe-area adjustment so UIKit’s keyboardLayoutGuide owns the composer’s bottom constraint. Send updates an in-memory card; no message leaves the app. Capture mode focuses the real UITextField after presentation settles. Floating keyboards, hardware keyboards, rotation, and accessibility sizes remain manual checks.

## Full example

[Open the complete runnable example](UIKitKeyboardBoundaryDemo.swift).

## Reference

[Apple documentation](https://developer.apple.com/documentation/swiftui/uiviewcontrollerrepresentable).

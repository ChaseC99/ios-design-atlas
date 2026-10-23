---
id: "presentation-control-environment"
title: "Control environments in presentations"
summary: "A presentation can establish different control defaults from the view that presents it."
category: "Versions & interop"
family: "Interoperability"
order: 3506
kind: "native"
demoMinIOS: "18.0"
swiftFile: "PresentationControlEnvironmentDemo.swift"
view: "PresentationControlEnvironmentDemo"
captureNavigation: true
ownsNavigation: false
apis: ["sheet", "popover", "controlSize", "buttonSizing", "buttonRepeatBehavior", "menuIndicator", "buttonBorderShape"]
tags: ["iOS 27", "environment", "SDK behavior", "sheet", "popover", "control defaults"]
---

# Control environments in presentations

A presentation can establish different control defaults from the view that presents it.

## SwiftUI

```swift
import SwiftUI

struct SheetControlProbe: View {
    @State private var presented = false
    var body: some View {
        Button("Open sheet") { presented = true }
            .sheet(isPresented: $presented) { ControlSizeReadout() }
            .controlSize(.large)
    }
}

struct ControlSizeReadout: View {
    @Environment(\.controlSize) private var size
    var body: some View {
        VStack {
            Text("Control size: \(String(describing: size))")
            Button("Example") {}.buttonStyle(.borderedProminent)
        }
    }
}
```

## Captures

<!-- captures:start -->
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Control environments in presentations on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792770894.617.png)
<!-- captures:end -->

## Example notes

Apple’s iOS 27 release notes describe an SDK-linked fix that resets controlSize, buttonSizing, buttonRepeatBehavior, menuIndicatorVisibility, and ButtonBorderShape in sheets and popovers. This probe sets those values on the presenter (buttonSizing only on iOS 26+) and can reapply them explicitly inside either presentation. Its readouts report observed environment values, not an assumed outcome. The atlas’s same-SDK runtime captures cannot isolate the effect of linking an older SDK. No affected-version regression or successful workaround is asserted without the corresponding builds and interaction checks.

## Full example

[Open the complete runnable example](PresentationControlEnvironmentDemo.swift).

## Reference

[Apple documentation](https://developer.apple.com/documentation/ios-ipados-release-notes/ios-ipados-27-release-notes).

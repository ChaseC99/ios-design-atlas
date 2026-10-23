---
id: "selectable-text-gesture-priority"
title: "Selectable text and custom gestures"
summary: "Selectable Text can share a gesture region with app interactions whose priority is explicit."
category: "Versions & interop"
family: "Interoperability"
order: 3507
kind: "native"
demoMinIOS: "18.0"
swiftFile: "SelectableTextGesturePriorityDemo.swift"
view: "SelectableTextGesturePriorityDemo"
captureNavigation: true
ownsNavigation: false
apis: ["textSelection", "simultaneousGesture", "highPriorityGesture", "TapGesture"]
tags: ["iOS 27", "text selection", "SDK behavior", "gesture priority", "copy"]
---

# Selectable text and custom gestures

Selectable Text can share a gesture region with app interactions whose priority is explicit.

## SwiftUI

```swift
import SwiftUI

struct SelectableTextWithAction: View {
    @State private var doubleTaps = 0
    var body: some View {
        VStack {
            Text("Take the long way home.")
                .textSelection(.enabled)
                .highPriorityGesture(TapGesture(count: 2).onEnded { doubleTaps += 1 })
            Text("Custom double-taps: \(doubleTaps)")
        }
    }
}
```

## Captures

<!-- captures:start -->
<!-- captures:end -->

## Example notes

Apple documents interactive system selection for selectable Text in apps built with the iOS 27 SDK, and recommends highPriorityGesture when a custom gesture should supersede selection gestures. The demo offers no custom gesture, simultaneous double-tap, and high-priority double-tap. A static capture does not verify selection gestures, callout menus, handles, or priority. Same-SDK runtime captures are not an older-SDK comparison; those builds and manual interaction recordings remain pending.

## Full example

[Open the complete runnable example](SelectableTextGesturePriorityDemo.swift).

## Reference

[Apple documentation](https://developer.apple.com/documentation/ios-ipados-release-notes/ios-ipados-27-release-notes).

---
id: "glass-morphing"
title: "Morphing glass controls"
summary: "Animate a compact control into a group of actions."
category: "Materials"
family: "Liquid Glass"
order: 806
kind: "native"
demoMinIOS: "26.0"
swiftFile: "GlassMorphingDemo.swift"
view: "GlassMorphingDemo"
captureNavigation: true
captureStyle: "screen"
apis: ["glassEffectID", "glassEffectTransition", "GlassEffectContainer"]
tags: ["animation", "morphing", "reduce motion"]
---

# Morphing glass controls

Stable glass effect identifiers let a container animate surfaces as controls appear, disappear, or change layout.

## SwiftUI

```swift
import SwiftUI

@available(iOS 26.0, *)
struct MorphingActions: View {
    @Namespace private var namespace
    @State private var expanded = false
    var body: some View {
        GlassEffectContainer(spacing: 24) {
            HStack(spacing: 16) {
                if expanded {
                    Image(systemName: "bookmark").padding(20)
                        .glassEffect().glassEffectID("save", in: namespace)
                }
                Button(expanded ? "Close" : "More") {
                    withAnimation(.spring()) { expanded.toggle() }
                }
                .padding(20).glassEffect(.regular.interactive())
                .glassEffectID("toggle", in: namespace)
            }
        }
    }
}
```

## Captures

<!-- captures:start -->
<!-- captures:end -->

## Full example

[Open the complete runnable example](GlassMorphingDemo.swift).

## Reference

[Apple: glassEffectID](https://developer.apple.com/documentation/swiftui/view/glasseffectid(_:in:)).

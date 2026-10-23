---
id: "contrast-transparency-adaptation"
title: "Contrast and transparency"
summary: "Semantic colors, opaque fallbacks, and explicit symbols preserve meaning across accessibility display preferences."
category: "Accessibility"
family: "Adaptation"
order: 2006
kind: "native"
demoMinIOS: "18.0"
swiftFile: "ContrastTransparencyAdaptationDemo.swift"
view: "ContrastTransparencyAdaptationDemo"
captureNavigation: true
ownsNavigation: false
captureEnvironmentNotes: "The default capture uses the system Large text setting. Preview controls affect only this example."
apis: ["accessibilityReduceTransparency", "colorSchemeContrast", "accessibilityDifferentiateWithoutColor"]
tags: ["contrast", "transparency", "differentiate without color", "status"]
---

# Contrast and transparency

Semantic colors, opaque fallbacks, and explicit symbols preserve meaning across accessibility display preferences.

## SwiftUI

```swift
import SwiftUI

struct AccessibleMaterialCard: View {
    @Environment(\.accessibilityReduceTransparency) private var opaque
    @Environment(\.colorSchemeContrast) private var contrast

    var body: some View {
        Label("Saved", systemImage: "checkmark.circle.fill")
            .padding(24)
            .background(opaque ? AnyShapeStyle(Color(uiColor: .systemBackground)) : AnyShapeStyle(.regularMaterial),
                        in: .rect(cornerRadius: 20))
            .overlay {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(contrast == .increased ? Color.primary : .clear, lineWidth: 2)
            }
    }
}
```

## Captures

<!-- captures:start -->
<!-- captures:end -->

## Verification

The default capture uses the system Large text setting. Preview controls affect only this example. No global accessibility settings are changed. Manual VoiceOver traversal, Voice Control, Switch Control, and hardware-keyboard checks remain pending; screenshots do not verify assistive-technology behavior.

## Full example

[Open the complete runnable example](ContrastTransparencyAdaptationDemo.swift).

## Reference

[Apple: accessibilityReduceTransparency](https://developer.apple.com/documentation/swiftui/environmentvalues/accessibilityreducetransparency).

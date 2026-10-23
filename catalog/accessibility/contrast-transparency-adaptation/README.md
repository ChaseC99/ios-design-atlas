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
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Contrast and transparency on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792765558.729.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Contrast and transparency on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792765476.836.png)
<!-- captures:end -->

## Verification

The default capture uses the system Large text setting. Preview controls affect only this example. No global accessibility settings are changed. Manual VoiceOver traversal, Voice Control, Switch Control, and hardware-keyboard checks remain pending; screenshots do not verify assistive-technology behavior.

## Full example

[Open the complete runnable example](ContrastTransparencyAdaptationDemo.swift).

## Reference

[Apple: accessibilityReduceTransparency](https://developer.apple.com/documentation/swiftui/environmentvalues/accessibilityreducetransparency).

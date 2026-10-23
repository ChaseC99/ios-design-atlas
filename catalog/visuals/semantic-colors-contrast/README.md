---
id: "semantic-colors-contrast"
title: "Semantic colors and contrast"
summary: "Let native foreground and background roles adapt together."
category: "Visuals"
family: "Color"
order: 1604
kind: "native"
demoMinIOS: "18.0"
swiftFile: "SemanticColorsContrastDemo.swift"
view: "SemanticColorsContrastDemo"
captureNavigation: true
ownsNavigation: false
captureStyle: "screen"
apis: ["foregroundStyle", "ColorScheme", "ColorSchemeContrast"]
tags: ["light", "dark", "contrast", "hierarchy"]
---

# Semantic colors and contrast

Semantic colors describe a role rather than a fixed appearance, allowing surfaces and foreground hierarchy to adapt to light, dark, and increased contrast.

## SwiftUI

```swift
import SwiftUI

struct SemanticCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("A clear hierarchy").font(.title2).foregroundStyle(.primary)
            Text("Supporting detail").foregroundStyle(.secondary)
            Text("Metadata").font(.caption).foregroundStyle(.tertiary)
        }
        .padding(24)
        .background(Color(uiColor: .secondarySystemGroupedBackground),
                    in: RoundedRectangle(cornerRadius: 24))
    }
}
```

## Captures

<!-- captures:start -->
<!-- captures:end -->

## Full example

[Open the complete runnable example](SemanticColorsContrastDemo.swift).

## Reference

[Apple: foregroundStyle](https://developer.apple.com/documentation/swiftui/color).

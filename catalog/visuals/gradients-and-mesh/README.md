---
id: "gradients-and-mesh"
title: "Gradients and mesh gradients"
summary: "Blend color along a line, around a center, or across a grid."
category: "Visuals"
family: "Color"
order: 1605
kind: "native"
demoMinIOS: "18.0"
swiftFile: "GradientsMeshDemo.swift"
view: "GradientsMeshDemo"
captureNavigation: true
ownsNavigation: false
captureStyle: "screen"
apis: ["LinearGradient", "RadialGradient", "AngularGradient", "MeshGradient"]
tags: ["gradient", "mesh", "control points"]
---

# Gradients and mesh gradients

Gradients interpolate color across a shape; a mesh gradient adds movable control points for a more flexible blend.

## SwiftUI

```swift
import SwiftUI

struct FourCornerMesh: View {
    var body: some View {
        MeshGradient(width: 2, height: 2,
                     points: [[0, 0], [1, 0], [0, 1], [1, 1]],
                     colors: [.indigo, .pink, .teal, .orange])
            .frame(height: 280)
            .clipShape(RoundedRectangle(cornerRadius: 28))
    }
}
```

## Captures

<!-- captures:start -->
<!-- captures:end -->

## Full example

[Open the complete runnable example](GradientsMeshDemo.swift).

## Reference

[Apple: LinearGradient](https://developer.apple.com/documentation/swiftui/meshgradient).

---
id: "sliding-selection-indicator"
title: "A sliding selection indicator"
summary: "Move one visual selection between custom segments."
category: "Custom patterns"
family: "Selection patterns"
order: 3407
kind: "custom"
demoMinIOS: "18.0"
swiftFile: "SlidingSelectionIndicatorDemo.swift"
view: "SlidingSelectionIndicatorDemo"
captureNavigation: true
ownsNavigation: false
captureStyle: "screen"
apis: ["matchedGeometryEffect", "Namespace", "Picker"]
tags: ["custom", "Sarun", "segmented control"]
---

# A sliding selection indicator

An original selection indicator inspired by Sarun’s [A first look at matchedGeometryEffect](https://sarunw.com/posts/a-first-look-at-matchedgeometryeffect/) (1 July 2020). Use a native segmented `Picker` when standard styling fits; this sample customizes the geometry and keeps button accessibility.

## SwiftUI

```swift
import SwiftUI

struct SlidingSegments: View {
    @Namespace private var indicator
    @State private var selected = "Read"
    var body: some View {
        HStack {
            ForEach(["Read", "Listen", "Watch"], id: \.self) { item in
                Button { withAnimation(.snappy) { selected = item } } label: {
                    Text(item).padding(.horizontal, 20).padding(.vertical, 14)
                        .foregroundStyle(selected == item ? .white : .primary)
                        .background {
                            if selected == item { Capsule().fill(.teal).matchedGeometryEffect(id: "active", in: indicator) }
                        }
                }.buttonStyle(.plain).accessibilityAddTraits(selected == item ? .isSelected : [])
            }
        }.padding(5).background(.teal.opacity(0.08), in: Capsule())
    }
}
```

## Captures

<!-- captures:start -->
<!-- captures:end -->

## Full example

[Open the complete runnable example](SlidingSelectionIndicatorDemo.swift).

## Reference

[Apple documentation](https://developer.apple.com/documentation/swiftui/view/matchedgeometryeffect(id:in:properties:anchor:issource:)).

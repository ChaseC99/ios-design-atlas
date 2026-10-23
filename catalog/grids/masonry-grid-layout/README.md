---
id: "masonry-grid-layout"
title: "Masonry layouts"
summary: "A custom masonry layout places each card in the shortest column to accommodate varied heights."
category: "Grids"
family: "Custom layouts"
order: 1008
kind: "custom"
demoMinIOS: "18.0"
swiftFile: "MasonryGridLayoutDemo.swift"
view: "MasonryGridLayoutDemo"
captureNavigation: true
ownsNavigation: false
apis: ["Layout", "sizeThatFits", "placeSubviews"]
tags: ["masonry", "variable heights", "columns", "adaptive"]
---

# Masonry layouts

A custom masonry layout places each card in the shortest column to accommodate varied heights.

## SwiftUI

```swift
import SwiftUI

struct MasonryLayout: Layout {
    var columns = 2
    var spacing: CGFloat = 12

    private func frames(_ width: CGFloat, _ views: Subviews) -> [CGRect] {
        let count = max(1, columns)
        let cellWidth = max(0, (width - spacing * CGFloat(count - 1)) / CGFloat(count))
        var heights = Array(repeating: CGFloat.zero, count: count)
        return views.map { view in
            let column = heights.indices.min { heights[$0] < heights[$1] } ?? 0
            let size = view.sizeThatFits(ProposedViewSize(width: cellWidth, height: nil))
            let frame = CGRect(x: CGFloat(column) * (cellWidth + spacing), y: heights[column], width: cellWidth, height: size.height)
            heights[column] = frame.maxY + spacing
            return frame
        }
    }

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let ideal = subviews.map { $0.sizeThatFits(.unspecified).width }.max() ?? 0
        let width = proposal.width ?? ideal * CGFloat(max(1, columns)) + spacing * CGFloat(max(0, columns - 1))
        return CGSize(width: width, height: frames(width, subviews).map(\.maxY).max() ?? 0)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        for (view, frame) in zip(subviews, frames(bounds.width, subviews)) {
            view.place(at: CGPoint(x: bounds.minX + frame.minX, y: bounds.minY + frame.minY),
                       anchor: .topLeading, proposal: ProposedViewSize(frame.size))
        }
    }
}

struct MasonryCards: View {
    var body: some View {
        MasonryLayout {
            ForEach(0..<8) { index in
                Color.teal.frame(height: index.isMultiple(of: 2) ? 160 : 220)
                    .clipShape(.rect(cornerRadius: 20))
            }
        }
    }
}
```

## Captures

<!-- captures:start -->
<!-- captures:end -->

## Full example

[Open the complete runnable example](MasonryGridLayoutDemo.swift).

## Reference

[Apple: Layout](https://developer.apple.com/documentation/swiftui/layout).

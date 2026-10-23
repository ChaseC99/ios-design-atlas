---
id: "source-transitions"
title: "Source-linked transitions"
summary: "A presentation with a visible origin."
category: "Presentation"
family: "Transitions"
order: 8
kind: "native"
demoMinIOS: "18.0"
swiftFile: "SourceTransitionsDemo.swift"
view: "SourceTransitionsDemo"
apis: ["matchedTransitionSource", "navigationTransition", "sheet"]
tags: ["animation", "zoom", "source"]
---

# Source-linked transitions

A source-linked zoom connects a reference card to its detail presentation. The switch makes it possible to compare the zoom with the default sheet transition using the same content.

## Try it in the app

1. Open the reference with Use source zoom enabled.
2. Dismiss using Done or the system dismissal gesture.
3. Disable zoom and repeat. Also try Reduce Motion.

## What to notice

- The namespace and source ID connect the source view to its destination.
- The source card remains in the underlying view hierarchy.
- A screenshot shows an endpoint. Inspect the actual animation in the example app.

## Captures

<!-- captures:start -->
Captures have not been recorded yet.
<!-- captures:end -->

## Comparison checklist

- [ ] Compare appearance and dismissal on each runtime.
- [ ] Check interrupted gestures and reduced-motion behavior.

## Swift source

[Open the complete runnable example](SourceTransitionsDemo.swift). The website displays this exact file.

## References

- [Apple: enhance your UI animations and transitions](https://developer.apple.com/videos/play/wwdc2024/10145/)

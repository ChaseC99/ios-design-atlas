---
id: "inspectors"
title: "Adaptive inspectors"
summary: "Attributes alongside the selected content."
category: "Presentation"
family: "Inspectors"
order: 7
kind: "native"
demoMinIOS: "18.0"
swiftFile: "InspectorsDemo.swift"
view: "InspectorsDemo"
apis: ["inspector", "inspectorColumnWidth", "presentationDetents"]
tags: ["adaptive", "column", "editing"]
---

# Adaptive inspectors

An inspector holds controls for the current selection. This example edits a reference title, favorite state, and rating, and asks for a trailing column when space permits.

## Try it in the app

1. Open the inspector on iPhone.
2. Change the title and favorite state, then dismiss.
3. Open on iPad and compare the inspector with the main content.

## What to notice

- An inspector can adapt to a sheet in compact width.
- Column-width preferences apply to a column presentation; the platform can constrain the result.
- The main view and inspector share the selected reference state.

## Captures

<!-- captures:start -->
Captures have not been recorded yet.
<!-- captures:end -->

## Comparison checklist

- [ ] Capture compact and regular-width layouts separately.
- [ ] Resize or rotate while the inspector is open and check that edits survive.

## Swift source

[Open the complete runnable example](InspectorsDemo.swift). The website displays this exact file.

## References

- [Apple: inspectors in SwiftUI](https://developer.apple.com/videos/play/wwdc2023/10161/)

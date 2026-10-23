---
id: "presentation-stress-tests"
title: "Long text & accessibility"
summary: "Make room for the less convenient cases."
category: "Presentation"
family: "Accessibility"
order: 9
kind: "native"
demoMinIOS: "18.0"
swiftFile: "PresentationStressTestsDemo.swift"
view: "PresentationStressTestsDemo"
apis: ["alert", "DynamicTypeSize", "ButtonRole"]
tags: ["dynamic-type", "localization", "long-text"]
---

# Long text & accessibility

Presentation layouts need to accommodate real content. This example uses a longer message, three actions, and explicit German sample copy to expose wrapping and action layout.

## Try it in the app

1. Present with short and long messages.
2. Switch to German sample copy and compare action labels.
3. Increase the simulator text size and enable VoiceOver.

## What to notice

- The German switch changes sample copy, not the application locale or layout direction.
- Use actual simulator language settings to evaluate right-to-left behavior.
- A capture at default text size does not establish accessibility support.

## Captures

<!-- captures:start -->
Captures have not been recorded yet.
<!-- captures:end -->

## Comparison checklist

- [ ] Verify that the full message and every action remain reachable.
- [ ] Record the text-size setting and language alongside each accessibility capture.

## Swift source

[Open the complete runnable example](PresentationStressTestsDemo.swift). The website displays this exact file.

## References

- [Apple: modal presentations](https://developer.apple.com/documentation/swiftui/modal-presentations)

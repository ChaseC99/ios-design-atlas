---
id: "popover-anchors"
title: "Popover anchors"
summary: "Keep a little context close to its source."
category: "Presentation"
family: "Popovers"
order: 4
kind: "native"
demoMinIOS: "18.0"
swiftFile: "PopoverAnchorsDemo.swift"
view: "PopoverAnchorsDemo"
apis: ["popover", "PopoverAttachmentAnchor", "presentationCompactAdaptation"]
tags: ["anchor", "arrow", "sizing"]
---

# Popover anchors

A popover is spatially connected to a control. This example exposes the attachment anchor, requested arrow edge, and content width while keeping a popover presentation in compact width.

## Try it in the app

1. Present the popover and dismiss it by tapping outside.
2. Switch between a bounds anchor and a center-point anchor.
3. Change the arrow-edge request and the content width.

## What to notice

- Attachment and arrow values are requests within the available space. Record the result on the actual runtime.
- An explicit compact adaptation keeps this example focused on anchored presentation.
- The content includes a Done action in addition to outside dismissal.

## Captures

<!-- captures:start -->
Captures have not been recorded yet.
<!-- captures:end -->

## Comparison checklist

- [ ] Try controls near an edge and rotate the device.
- [ ] Compare requested width with the space the system can actually provide.

## Swift source

[Open the complete runnable example](PopoverAnchorsDemo.swift). The website displays this exact file.

## References

- [Apple: modal presentations](https://developer.apple.com/documentation/swiftui/modal-presentations)

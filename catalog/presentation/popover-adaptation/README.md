---
id: "popover-adaptation"
title: "Popover adaptation"
summary: "One view, two presentation contexts."
category: "Presentation"
family: "Popovers"
order: 5
kind: "native"
demoMinIOS: "18.0"
swiftFile: "PopoverAdaptationDemo.swift"
view: "PopoverAdaptationDemo"
apis: ["popover", "presentationCompactAdaptation"]
tags: ["compact", "sheet", "adaptive"]
---

# Popover adaptation

The same popover content can be presented differently when space is compact. The Keep popover switch makes that adaptation preference explicit.

## Try it in the app

1. Present with Keep popover off.
2. Dismiss, turn Keep popover on, and present again.
3. Repeat the comparison on an iPad or wider window.

## What to notice

- Automatic adaptation lets the system choose a suitable presentation.
- The explicit popover preference is applied to the presented content.
- Close and reopen after changing the configuration for a clear comparison.

## Captures

<!-- captures:start -->
Captures have not been recorded yet.
<!-- captures:end -->

## Comparison checklist

- [ ] Compare both configurations on the same runtime and device.
- [ ] Check landscape and accessibility text sizes as well as portrait.

## Swift source

[Open the complete runnable example](PopoverAdaptationDemo.swift). The website displays this exact file.

## References

- [Apple: modal presentations](https://developer.apple.com/documentation/swiftui/modal-presentations)

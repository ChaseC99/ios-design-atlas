---
id: "popover-content"
title: "Content inside popovers"
summary: "Lists, forms, and a small navigation stack."
category: "Presentation"
family: "Popovers"
order: 6
kind: "native"
demoMinIOS: "18.0"
swiftFile: "PopoverContentDemo.swift"
view: "PopoverContentDemo"
apis: ["popover", "NavigationStack", "List", "Form"]
tags: ["navigation", "editing", "containers"]
---

# Content inside popovers

Popovers can host more than a short message. This example puts either a collection browser or a compact form inside a bounded navigation stack.

## Try it in the app

1. Choose List, present, and navigate into a collection.
2. Choose the collection and verify the updated value.
3. Switch to Form and edit the collection name.

## What to notice

- The explicit dimensions demonstrate a bounded container; they are not a universal sizing recommendation.
- Long content can scroll within the List or Form.
- A Done action remains available inside the presentation.

## Captures

<!-- captures:start -->
Captures have not been recorded yet.
<!-- captures:end -->

## Comparison checklist

- [ ] Check that navigation titles and actions fit at large text sizes.
- [ ] Try editing with the keyboard visible and verify all controls remain reachable.

## Swift source

[Open the complete runnable example](PopoverContentDemo.swift). The website displays this exact file.

## References

- [Apple: modal presentations](https://developer.apple.com/documentation/swiftui/modal-presentations)

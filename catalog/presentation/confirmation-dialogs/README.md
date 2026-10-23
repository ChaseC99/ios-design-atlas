---
id: "confirmation-dialogs"
title: "Confirmation dialogs"
summary: "Related actions, attached to their context."
category: "Presentation"
family: "Dialogs"
order: 3
kind: "native"
demoMinIOS: "18.0"
swiftFile: "ConfirmationDialogsDemo.swift"
view: "ConfirmationDialogsDemo"
apis: ["confirmationDialog", "ButtonRole"]
tags: ["actions", "adaptive", "destructive"]
---

# Confirmation dialogs

A confirmation dialog offers a short list of actions for the selected item. The trigger is also the presentation source, which matters when the dialog adapts to a popover.

## Try it in the app

1. Open Photo actions and choose Save a Copy.
2. Toggle title visibility and compare the result.
3. Open the same example on a regular-width device.

## What to notice

- The system may reorder actions according to their roles.
- Regular-width presentations can use a popover, with outside tapping handling cancellation.
- Use text labels for confirmation-dialog actions.

## Captures

<!-- captures:start -->
Captures have not been recorded yet.
<!-- captures:end -->

## Comparison checklist

- [ ] Compare compact and regular-width presentation.
- [ ] Verify the destructive action remains distinct without relying on color alone.

## Swift source

[Open the complete runnable example](ConfirmationDialogsDemo.swift). The website displays this exact file.

## References

- [Apple: modal presentations](https://developer.apple.com/documentation/swiftui/modal-presentations)

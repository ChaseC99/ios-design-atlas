---
id: "local-account-and-data"
title: "Account privacy and data controls"
summary: "Export or remove a clearly scoped local sample."
category: "Privacy"
family: "Account controls"
order: 3006
kind: "custom"
demoMinIOS: "18.0"
swiftFile: "LocalAccountDataDemo.swift"
view: "LocalAccountDataDemo"
apis: ["fileExporter", "FileDocument", "confirmationDialog", "Toggle"]
tags: ["privacy-settings", "data-export", "account-deletion", "confirmation", "local-fixture"]
captureNavigation: true
captureStyle: "screen"
---

# Account privacy and data controls

Privacy settings should explain what changes and let someone export or remove their data deliberately. This app-owned composition exports only a small JSON fixture and uses a native confirmation dialog to delete its in-memory sample account. It does not connect to an identity provider or delete any real account.

## SwiftUI

```swift
import SwiftUI

struct DeleteSampleRecipe: View {
    @State private var exists = true
    @State private var confirming = false
    var body: some View {
        VStack(spacing: 20) {
            Text(exists ? "Sample account" : "Sample removed")
            Button(exists ? "Delete sample account" : "Restore sample", role: exists ? .destructive : nil) {
                if exists { confirming = true } else { exists = true }
            }
        }
        .confirmationDialog("Delete this local sample account?", isPresented: $confirming, titleVisibility: .visible) {
            Button("Delete sample", role: .destructive) { exists = false }
            Button("Cancel", role: .cancel) { confirming = false }
        } message: { Text("Only the in-memory demonstration is removed.") }
    }
}
```

## Captures

<!-- captures:start -->
Captures have not been recorded yet.
<!-- captures:end -->

## Full example

[Open the complete runnable example](LocalAccountDataDemo.swift).

## Reference

[Apple: Privacy](https://developer.apple.com/design/human-interface-guidelines/privacy).

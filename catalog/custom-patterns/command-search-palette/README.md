---
id: "command-search-palette"
title: "A searchable command palette"
summary: "Find an action and apply it to the current workspace."
category: "Custom patterns"
family: "Action patterns"
order: 3405
kind: "custom"
demoMinIOS: "18.0"
swiftFile: "CommandSearchPaletteDemo.swift"
view: "CommandSearchPaletteDemo"
captureNavigation: true
ownsNavigation: false
captureStyle: "screen"
apis: ["TextField", "keyboardShortcut", "overlay"]
tags: ["custom", "command search", "keyboard"]
---

# A searchable command palette

A custom command palette filters actions and executes the selected command. A native `Menu` is usually sufficient for a short, fixed list of actions.

## SwiftUI

```swift
import SwiftUI

struct ActionSearch: View {
    @State private var query = ""
    @State private var favorites = false
    var body: some View {
        VStack(alignment: .leading) {
            TextField("Search actions", text: $query).textFieldStyle(.roundedBorder)
            if query.isEmpty || "Toggle favorites".localizedCaseInsensitiveContains(query) {
                Button("Toggle favorites", systemImage: "star") { favorites.toggle() }
            }
            Text(favorites ? "Showing favorites" : "Showing all notes")
        }.padding(24).background(.regularMaterial, in: .rect(cornerRadius: 24))
    }
}
```

## Captures

<!-- captures:start -->
<!-- captures:end -->

## Full example

[Open the complete runnable example](CommandSearchPaletteDemo.swift).

## Reference

[Apple documentation](https://developer.apple.com/documentation/swiftui/view/keyboardshortcut(_:modifiers:)).

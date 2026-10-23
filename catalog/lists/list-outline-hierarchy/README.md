---
id: "list-outline-hierarchy"
title: "Outlines and expandable sections"
summary: "Disclosure groups reveal a hierarchy without leaving the surrounding list."
category: "Lists"
family: "Structure"
order: 906
kind: "native"
demoMinIOS: "18.0"
swiftFile: "ListOutlineHierarchyDemo.swift"
view: "ListOutlineHierarchyDemo"
captureNavigation: true
ownsNavigation: false
apis: ["OutlineGroup", "DisclosureGroup", "Section"]
tags: ["hierarchy", "expand", "collapse", "nested"]
---

# Outlines and expandable sections

Disclosure groups reveal a hierarchy without leaving the surrounding list.

## SwiftUI

```swift
import SwiftUI

struct FolderOutline: View {
    struct Folder: Identifiable {
        let id: String
        var children: [Folder]?
    }
    private let folders = [
        Folder(id: "Travel", children: [
            Folder(id: "Coastal walks"),
            Folder(id: "City weekends")
        ])
    ]

    var body: some View {
        List {
            OutlineGroup(folders, children: \.children) { folder in
                Label(folder.id, systemImage: "folder")
            }
        }
    }
}
```

## Captures

<!-- captures:start -->
<!-- captures:end -->

## Full example

[Open the complete runnable example](ListOutlineHierarchyDemo.swift).

## Reference

[Apple: OutlineGroup](https://developer.apple.com/documentation/swiftui/outlinegroup).

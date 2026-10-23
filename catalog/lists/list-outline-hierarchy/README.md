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
### iPhone 16 Pro · iOS 18.5

default. light appearance; Large text; en_US.

![Outlines and expandable sections on iPhone 16 Pro, iOS 18.5](captures/ios-18-5-iphone-16-pro-default-1792766057.906.png)

### iPhone 17 Pro · iOS 26.5

default. light appearance; Large text; en_US.

![Outlines and expandable sections on iPhone 17 Pro, iOS 26.5](captures/ios-26-5-iphone-17-pro-default-1792765817.878.png)

### iPhone 18 Pro · iOS 27.0

default. light appearance; Large text; en_US.

![Outlines and expandable sections on iPhone 18 Pro, iOS 27.0](captures/ios-27-0-iphone-18-pro-default-1792768044.231.png)
<!-- captures:end -->

## Full example

[Open the complete runnable example](ListOutlineHierarchyDemo.swift).

## Reference

[Apple: OutlineGroup](https://developer.apple.com/documentation/swiftui/outlinegroup).

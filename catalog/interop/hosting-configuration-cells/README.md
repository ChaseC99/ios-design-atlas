---
id: "hosting-configuration-cells"
title: "SwiftUI content in UIKit cells"
summary: "UIHostingConfiguration supplies SwiftUI content while UIKit owns the table and cell lifecycle."
category: "Versions & interop"
family: "Interoperability"
order: 3503
kind: "native"
demoMinIOS: "18.0"
swiftFile: "HostingConfigurationCellsDemo.swift"
view: "HostingConfigurationCellsDemo"
captureNavigation: true
ownsNavigation: false
apis: ["UIHostingConfiguration", "UITableView", "UITableViewDataSource", "UIViewRepresentable"]
tags: ["UIKit", "table cells", "SwiftUI", "hosting configuration", "selection"]
---

# SwiftUI content in UIKit cells

UIHostingConfiguration supplies SwiftUI content while UIKit owns the table and cell lifecycle.

## SwiftUI

```swift
import SwiftUI
import UIKit

@MainActor
func configurePlaceCell(_ cell: UITableViewCell, title: String, saved: Bool) {
    cell.contentConfiguration = UIHostingConfiguration {
        HStack {
            Label(title, systemImage: "tree")
            Spacer()
            Image(systemName: saved ? "bookmark.fill" : "bookmark")
        }.padding(.vertical, 10)
    }
}
```

## Captures

<!-- captures:start -->
<!-- captures:end -->

## Example notes

Rows are real UITableView cells with UIHostingConfiguration content. UIKit selection updates a SwiftUI Set; updates reconfigure visible content. The four places are fictional. Dynamic Type and VoiceOver behavior still require manual review.

## Full example

[Open the complete runnable example](HostingConfigurationCellsDemo.swift).

## Reference

[Apple documentation](https://developer.apple.com/documentation/swiftui/uihostingconfiguration).

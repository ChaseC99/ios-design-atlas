---
id: "wide-inspector-workspace"
title: "A workspace with an inspector"
summary: "Keep navigation, content, and document settings within reach."
category: "Wide layouts"
family: "Adaptive workspaces"
order: 2301
kind: "native"
demoMinIOS: "18.0"
swiftFile: "WideInspectorWorkspaceDemo.swift"
view: "WideInspectorWorkspaceDemo"
captureNavigation: false
ownsNavigation: true
captureStyle: "screen"
apis: ["NavigationSplitView", "inspector", "inspectorColumnWidth"]
tags: ["iPad", "sidebar", "document"]
---

# A workspace with an inspector

A split view can show a sidebar, content column, detail, and inspector together; compact windows adapt those regions into navigation and a sheet.

## SwiftUI

```swift
import SwiftUI

struct DocumentWorkspace: View {
    @State private var inspector = false
    var body: some View {
        NavigationSplitView {
            List { NavigationLink("Journal") { Text("A slower morning") } }
                .navigationTitle("Notebooks")
        } detail: {
            Text("A slower morning")
                .toolbar {
                    Button("Inspector", systemImage: "sidebar.right") { inspector.toggle() }
                }
                .inspector(isPresented: $inspector) {
                    Form { LabeledContent("Notebook", value: "Journal") }
                        .inspectorColumnWidth(min: 240, ideal: 280, max: 340)
                }
        }
    }
}
```

## Captures

<!-- captures:start -->
<!-- captures:end -->

## Full example

[Open the complete runnable example](WideInspectorWorkspaceDemo.swift).

## Reference

[Apple: NavigationSplitView](https://developer.apple.com/documentation/swiftui/navigationsplitview).

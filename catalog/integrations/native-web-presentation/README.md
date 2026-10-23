---
id: "native-web-presentation"
title: "Web views and browser presentation"
summary: "Compare embedded local HTML with a system browser."
category: "Integrations"
family: "Web content"
order: 2903
kind: "native"
demoMinIOS: "18.0"
swiftFile: "NativeWebPresentationDemo.swift"
view: "NativeWebPresentationDemo"
apis: ["WKWebView", "SFSafariViewController", "UIViewRepresentable", "UIViewControllerRepresentable"]
tags: ["web", "safari", "local-html", "uikit-wrapper"]
captureNavigation: true
captureStyle: "screen"
---

# Web views and browser presentation

WKWebView embeds web content within a native layout, while SFSafariViewController offers browser controls for a destination the user opens. The embedded page here is a local HTML fixture with no network requests; the public Apple design page opens only from the browser button.

## SwiftUI

```swift
import SwiftUI
import SafariServices

struct SafariRecipe: View {
    @State private var presented = false
    var body: some View {
        Button("Open Apple design") { presented = true }
            .sheet(isPresented: $presented) { SafariPage() }
    }
}

private struct SafariPage: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> SFSafariViewController {
        SFSafariViewController(url: URL(string: "https://developer.apple.com/design/")!)
    }
    func updateUIViewController(_ controller: SFSafariViewController, context: Context) {}
}
```

## Captures

<!-- captures:start -->
Captures have not been recorded yet.
<!-- captures:end -->

## Full example

[Open the complete runnable example](NativeWebPresentationDemo.swift).

## Reference

[Apple: SFSafariViewController](https://developer.apple.com/documentation/safariservices/sfsafariviewcontroller).

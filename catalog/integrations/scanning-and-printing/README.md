---
id: "scanning-and-printing"
title: "Scanning and printing"
summary: "Bridge native document, text, and print interfaces."
category: "Integrations"
family: "UIKit interfaces"
order: 2906
kind: "native"
demoMinIOS: "18.0"
swiftFile: "ScanningPrintingDemo.swift"
view: "ScanningPrintingDemo"
apis: ["VNDocumentCameraViewController", "DataScannerViewController", "UIPrintInteractionController", "UIViewControllerRepresentable"]
tags: ["scanner", "camera", "text-recognition", "print", "uikit-wrapper", "setup-required"]
captureNavigation: true
captureStyle: "screen"
---

# Scanning and printing

VisionKit offers native document and live-text scanners, while the print controller presents system printer options for a local document. Camera controls require supported hardware and NSCameraUsageDescription, and open only from a tap. Printing uses the sample note; captures show these real controls without accessing the camera or sending a print job.

## SwiftUI

```swift
import SwiftUI
import UIKit

struct PrintRecipe: View {
    var body: some View { PrintButton().frame(height: 44).padding() }
}
private struct PrintButton: UIViewRepresentable {
    func makeUIView(context: Context) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle("Print sample notes", for: .normal)
        button.addAction(UIAction { [weak button] _ in
            guard let button else { return }
            guard UIPrintInteractionController.isPrintingAvailable else { return }
            let controller = UIPrintInteractionController.shared
            let info = UIPrintInfo(dictionary: nil); info.jobName = "Weekend notes"
            controller.printInfo = info
            controller.printFormatter = UIMarkupTextPrintFormatter(markupText: "<h1>Weekend notes</h1><p>Meet at the harbor at 9.</p>")
            controller.present(from: button.bounds, in: button, animated: true, completionHandler: nil)
        }, for: .touchUpInside)
        return button
    }
    func updateUIView(_ button: UIButton, context: Context) {}
}
```

## Captures

<!-- captures:start -->
Captures have not been recorded yet.
<!-- captures:end -->

## Full example

[Open the complete runnable example](ScanningPrintingDemo.swift).

## Reference

[Apple: VisionKit](https://developer.apple.com/documentation/visionkit).

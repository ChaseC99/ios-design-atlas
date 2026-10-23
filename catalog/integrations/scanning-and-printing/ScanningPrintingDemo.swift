import SwiftUI
import VisionKit
import AVFoundation
import UIKit

struct ScanningPrintingDemo: View {
    private enum Scanner: String, Identifiable { case document, text; var id: String { rawValue } }
    @State private var scanner: Scanner?
    @State private var status = "No scan started"
    private var cameraConfigured: Bool { !(Bundle.main.object(forInfoDictionaryKey: "NSCameraUsageDescription") as? String ?? "").isEmpty }
    var body: some View {
        Form {
            Section {
                VStack(alignment: .leading, spacing: 14) {
                    Image(systemName: "doc.text.viewfinder").font(.system(size: 54)).foregroundStyle(.teal)
                    Text("Weekend notes").font(.title.bold())
                    Text("Meet at the harbor at 9.\nBring a notebook.\nTake the scenic route.").lineSpacing(8).foregroundStyle(.secondary)
                }.padding(.vertical, 20)
            }
            Section("Scan") {
                Button("Scan a document", systemImage: "doc.viewfinder") { open(.document) }
                    .disabled(!cameraConfigured || !VNDocumentCameraViewController.isSupported)
                Button("Scan text", systemImage: "text.viewfinder") { open(.text) }
                    .disabled(!cameraConfigured || !DataScannerViewController.isSupported)
                if !cameraConfigured { Text("Camera scanning needs NSCameraUsageDescription in the app target.").font(.caption).foregroundStyle(.secondary) }
                else if !VNDocumentCameraViewController.isSupported { Text("Document scanning needs a supported physical device.").font(.caption).foregroundStyle(.secondary) }
            }
            Section("Print") {
                AtlasPrintButton { status = $0 }.frame(height: 44)
                Text(status).font(.caption).foregroundStyle(.secondary)
            }
        }
        .sheet(item: $scanner) { selection in
            switch selection {
            case .document: AtlasDocumentScanner { status = $0; scanner = nil }.ignoresSafeArea()
            case .text:
                NavigationStack {
                    AtlasTextScanner { status = $0; scanner = nil }.ignoresSafeArea(edges: .bottom)
                        .navigationTitle("Scan text").navigationBarTitleDisplayMode(.inline)
                        .toolbar { ToolbarItem(placement: .cancellationAction) { Button("Cancel") { status = "Text scan cancelled"; scanner = nil } } }
                }
            }
        }
        .navigationTitle("Scanning and printing").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
    private func open(_ selection: Scanner) {
        guard cameraConfigured else { status = "Camera usage description is missing"; return }
        Task {
            let allowed: Bool
            if AVCaptureDevice.authorizationStatus(for: .video) == .authorized { allowed = true }
            else { allowed = await AVCaptureDevice.requestAccess(for: .video) }
            guard allowed else { status = "Camera access is unavailable; review access in Settings"; return }
            if selection == .text && !DataScannerViewController.isAvailable { status = "Live text scanning is unavailable on this device"; return }
            scanner = selection
        }
    }
}
private struct AtlasPrintButton: UIViewRepresentable {
    var completed: (String) -> Void
    func makeUIView(context: Context) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle("Print sample notes", for: .normal)
        button.contentHorizontalAlignment = .leading
        button.isEnabled = UIPrintInteractionController.isPrintingAvailable
        button.addAction(UIAction { [weak button] _ in
            guard let button else { return }
            let controller = UIPrintInteractionController.shared
            let info = UIPrintInfo(dictionary: nil); info.jobName = "Atlas Weekend Notes"
            controller.printInfo = info
            controller.printFormatter = UIMarkupTextPrintFormatter(markupText: "<h1>Weekend notes</h1><p>Meet at the harbor at 9.</p><p>Bring a notebook.<br>Take the scenic route.</p>")
            controller.present(from: button.bounds, in: button, animated: true) { _, didPrint, error in
                completed(error != nil ? "Printing failed" : didPrint ? "Print job submitted" : "Printing cancelled")
            }
        }, for: .touchUpInside)
        return button
    }
    func updateUIView(_ button: UIButton, context: Context) {}
}
private struct AtlasDocumentScanner: UIViewControllerRepresentable {
    var completed: (String) -> Void
    func makeCoordinator() -> Coordinator { Coordinator(completed) }
    func makeUIViewController(context: Context) -> VNDocumentCameraViewController {
        let controller = VNDocumentCameraViewController(); controller.delegate = context.coordinator; return controller
    }
    func updateUIViewController(_ controller: VNDocumentCameraViewController, context: Context) {}
    final class Coordinator: NSObject, VNDocumentCameraViewControllerDelegate {
        let completed: (String) -> Void
        init(_ completed: @escaping (String) -> Void) { self.completed = completed }
        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) { completed("Scanned \(scan.pageCount) pages · Nothing saved") }
        func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) { completed("Document scan cancelled") }
        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: Error) { completed("Document scan failed") }
    }
}
private struct AtlasTextScanner: UIViewControllerRepresentable {
    var completed: (String) -> Void
    func makeUIViewController(context: Context) -> Host { Host(completed: completed) }
    func updateUIViewController(_ controller: Host, context: Context) {}
    final class Host: UIViewController, DataScannerViewControllerDelegate {
        let scanner = DataScannerViewController(recognizedDataTypes: [.text()], isHighlightingEnabled: true)
        let completed: (String) -> Void
        init(completed: @escaping (String) -> Void) { self.completed = completed; super.init(nibName: nil, bundle: nil) }
        required init?(coder: NSCoder) { fatalError("init(coder:) is unsupported") }
        override func viewDidLoad() {
            super.viewDidLoad()
            scanner.delegate = self
            addChild(scanner); view.addSubview(scanner.view)
            scanner.view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                scanner.view.leadingAnchor.constraint(equalTo: view.leadingAnchor), scanner.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                scanner.view.topAnchor.constraint(equalTo: view.topAnchor), scanner.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
            scanner.didMove(toParent: self)
        }
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            do { try scanner.startScanning() } catch { completed("Text scanning could not start") }
        }
        override func viewDidDisappear(_ animated: Bool) { scanner.stopScanning(); super.viewDidDisappear(animated) }
        func dataScanner(_ dataScanner: DataScannerViewController, didTapOn item: RecognizedItem) {
            if case .text = item { completed("Text recognized · Nothing saved") }
        }
    }
}

#Preview { NavigationStack { ScanningPrintingDemo() } }

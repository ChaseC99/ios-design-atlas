import SwiftUI
import AVFoundation

struct CameraCaptureEntryDemo: View {
    @State private var presented = false
    @State private var image: UIImage?
    @State private var status = "Capture a moment for your journal."
    @State private var requesting = false
    @State private var visible = true
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("Keep a moment.").font(.system(.largeTitle, design: .serif))
            Group {
                if let image { Image(uiImage: image).resizable().scaledToFit() }
                else {
                    RoundedRectangle(cornerRadius: 26).fill(.teal.opacity(0.1))
                        .overlay(Image(systemName: "camera").font(.system(size: 72, weight: .ultraLight)).foregroundStyle(.teal))
                }
            }.aspectRatio(0.9, contentMode: .fit).clipShape(.rect(cornerRadius: 26))
            Button("Open camera", systemImage: "camera.fill") { Task { await openCamera() } }
                .buttonStyle(.borderedProminent).controlSize(.large).disabled(requesting)
            Text(status).foregroundStyle(.secondary)
            Spacer()
        }.padding(24).frame(maxWidth: 650).frame(maxWidth: .infinity)
        .fullScreenCover(isPresented: $presented) {
            CameraSurface { result in
                if let result { image = result; status = "Photo captured for this session." }
                else { status = "Capture canceled." }
                presented = false
            }.ignoresSafeArea()
        }
        .navigationTitle("Journal camera").navigationBarTitleDisplayMode(.inline)
        .onAppear { visible = true }
        .onDisappear { visible = false }
        .accessibilityIdentifier("capture-ready")
    }
    private func openCamera() async {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else { status = "A camera is not available on this device."; return }
        guard Bundle.main.object(forInfoDictionaryKey: "NSCameraUsageDescription") is String else { status = "Camera access is not configured in this app build."; return }
        requesting = true
        defer { requesting = false }
        let authorization = AVCaptureDevice.authorizationStatus(for: .video)
        let allowed: Bool
        if authorization == .authorized { allowed = true }
        else if authorization == .notDetermined { allowed = await AVCaptureDevice.requestAccess(for: .video) }
        else { allowed = false }
        guard visible && !Task.isCancelled else { return }
        if allowed { presented = true } else { status = "Camera access is unavailable. You can review access in Settings." }
    }
    private struct CameraSurface: UIViewControllerRepresentable {
        let completion: (UIImage?) -> Void
        func makeCoordinator() -> Coordinator { Coordinator(completion: completion) }
        func makeUIViewController(context: Context) -> UIImagePickerController {
            let picker = UIImagePickerController(); picker.sourceType = .camera; picker.delegate = context.coordinator; return picker
        }
        func updateUIViewController(_ controller: UIImagePickerController, context: Context) { }
        final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
            let completion: (UIImage?) -> Void
            init(completion: @escaping (UIImage?) -> Void) { self.completion = completion }
            func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) { completion(info[.originalImage] as? UIImage) }
            func imagePickerControllerDidCancel(_ picker: UIImagePickerController) { completion(nil) }
        }
    }
}
#Preview { NavigationStack { CameraCaptureEntryDemo() } }

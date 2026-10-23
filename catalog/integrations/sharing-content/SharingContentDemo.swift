import SwiftUI
import UIKit

struct SharingContentDemo: View {
    @State private var textURL: URL?
    @State private var imageURL: URL?
    @State private var error: String?
    private let note = "Meet at the harbor at 9. Bring a notebook and take the scenic route."
    var body: some View {
        Form {
            Section {
                VStack(alignment: .leading, spacing: 18) {
                    Image(systemName: "sun.horizon.fill").font(.system(size: 56)).foregroundStyle(.orange)
                    Text("A slower Saturday").font(.title.bold())
                    Text(note).foregroundStyle(.secondary)
                }.padding(.vertical, 20)
                ShareLink(item: note, subject: Text("A slower Saturday")) { Label("Share text", systemImage: "text.bubble") }
                ShareLink(item: URL(string: "https://developer.apple.com/design/")!) { Label("Share a link", systemImage: "link") }
            }
            Section("Local files") {
                if let textURL { ShareLink(item: textURL) { Label("Share notes.txt", systemImage: "doc.text") } }
                if let imageURL {
                    ShareLink(item: imageURL, preview: SharePreview("Botanical study", image: Image(systemName: "leaf.fill"))) {
                        Label("Share botanical.png", systemImage: "photo")
                    }
                }
                if let error { Text(error).foregroundStyle(.secondary) }
            }
        }
        .navigationTitle("Sharing content").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier(textURL != nil && imageURL != nil ? "capture-ready" : "sharing-initializing")
        .task { prepareFiles() }
    }
    private func prepareFiles() {
        do {
            let folder = FileManager.default.temporaryDirectory.appending(path: "atlas-sharing", directoryHint: .isDirectory)
            try FileManager.default.createDirectory(at: folder, withIntermediateDirectories: true)
            let text = folder.appending(path: "notes.txt")
            try note.write(to: text, atomically: true, encoding: .utf8)
            let image = UIGraphicsImageRenderer(size: CGSize(width: 600, height: 600)).image { context in
                UIColor.systemTeal.withAlphaComponent(0.08).setFill()
                context.fill(CGRect(x: 0, y: 0, width: 600, height: 600))
                UIImage(systemName: "leaf.fill")?.withTintColor(.systemTeal, renderingMode: .alwaysOriginal)
                    .draw(in: CGRect(x: 150, y: 150, width: 300, height: 300))
            }
            let photo = folder.appending(path: "botanical.png")
            guard let data = image.pngData() else { return }
            try data.write(to: photo)
            textURL = text; imageURL = photo
        } catch { self.error = error.localizedDescription }
    }
}

#Preview { NavigationStack { SharingContentDemo() } }

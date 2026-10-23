import SwiftUI
import UniformTypeIdentifiers
import QuickLook

struct FilesQuickLookDemo: View {
    @State private var text = "WEEKEND NOTES\n\nMeet at the harbor at 9.\nBring a notebook.\nTake the scenic route."
    @State private var importing = false
    @State private var exporting = false
    @State private var previewURL: URL?
    @State private var status = "Local text document"
    var body: some View {
        Form {
            Section {
                Label("Weekend notes", systemImage: "doc.text.fill").font(.title2.bold()).foregroundStyle(.teal)
                TextEditor(text: $text).frame(minHeight: 210).font(.body.monospaced())
                Text(status).font(.caption).foregroundStyle(.secondary)
            }
            Section("Document actions") {
                Button("Import text file", systemImage: "square.and.arrow.down") { importing = true }
                Button("Export notes", systemImage: "square.and.arrow.up") { exporting = true }
                Button("Quick Look preview", systemImage: "eye") { preview() }
            }
        }
        .fileImporter(isPresented: $importing, allowedContentTypes: [.plainText]) { result in
            do {
                let url = try result.get()
                let access = url.startAccessingSecurityScopedResource()
                defer { if access { url.stopAccessingSecurityScopedResource() } }
                let size = try url.resourceValues(forKeys: [.fileSizeKey]).fileSize ?? 0
                guard size <= 1_000_000 else { status = "Choose a text file smaller than 1 MB"; return }
                text = try String(contentsOf: url, encoding: .utf8)
                status = "Imported \(url.lastPathComponent)"
            } catch { status = "Import cancelled or failed" }
        }
        .fileExporter(isPresented: $exporting, document: AtlasNotesDocument(text: text), contentType: .plainText, defaultFilename: "Weekend notes") { result in
            switch result { case .success: status = "Notes exported"; case .failure: status = "Export cancelled or failed" }
        }
        .quickLookPreview($previewURL)
        .navigationTitle("Files and Quick Look").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
    private func preview() {
        do {
            let url = FileManager.default.temporaryDirectory.appending(path: "Atlas Weekend Notes.txt")
            try text.write(to: url, atomically: true, encoding: .utf8)
            previewURL = url
        } catch { status = error.localizedDescription }
    }
}

private struct AtlasNotesDocument: FileDocument {
    static var readableContentTypes: [UTType] { [.plainText] }
    var text: String
    init(text: String) { self.text = text }
    init(configuration: ReadConfiguration) throws {
        text = String(decoding: configuration.file.regularFileContents ?? Data(), as: UTF8.self)
    }
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper { FileWrapper(regularFileWithContents: Data(text.utf8)) }
}

#Preview { NavigationStack { FilesQuickLookDemo() } }

import SwiftUI
import UniformTypeIdentifiers

struct LocalAccountDataDemo: View {
    @State private var includeNotes = true
    @State private var includeFavorites = true
    @State private var confirming = false
    @State private var exporting = false
    @State private var deleted = false
    @State private var status = "Local sample · No account service connected"
    var body: some View {
        Group {
            if deleted {
                ContentUnavailableView {
                    Label("Sample account removed", systemImage: "person.crop.circle.badge.minus")
                } description: { Text("Only this in-memory demonstration was removed.") }
                actions: { Button("Restore sample") { deleted = false; status = "Local sample restored" }.buttonStyle(.borderedProminent) }
            } else {
                Form {
                    Section {
                        HStack(spacing: 18) {
                            Image(systemName: "person.crop.circle.fill").font(.system(size: 54)).foregroundStyle(.teal)
                            VStack(alignment: .leading, spacing: 6) {
                                Text("Sample member").font(.title2.bold())
                                Text("Local demonstration account").font(.subheadline).foregroundStyle(.secondary)
                            }
                        }.padding(.vertical, 16)
                    }
                    Section("Export preferences") {
                        Toggle("Include sample notes", isOn: $includeNotes)
                        Toggle("Include sample favorites", isOn: $includeFavorites)
                        Button("Export sample data", systemImage: "square.and.arrow.up") { exporting = true }
                    }
                    Section("Account controls") {
                        Button("Delete sample account", role: .destructive) { confirming = true }
                        Text(status).font(.caption).foregroundStyle(.secondary)
                    }
                }
            }
        }
        .confirmationDialog("Delete this local sample account?", isPresented: $confirming, titleVisibility: .visible) {
            Button("Delete sample account", role: .destructive) { deleted = true; status = "Local sample removed" }
            Button("Cancel", role: .cancel) { confirming = false }
        } message: { Text("This removes only the in-memory sample. No real account or saved file is affected.") }
        .fileExporter(isPresented: $exporting, document: SamplePrivacyDocument(text: exportJSON), contentType: .json, defaultFilename: "Atlas sample data") { result in
            switch result { case .success: status = "Sample data exported"; case .failure: status = "Export cancelled or failed" }
        }
        .navigationTitle("Account and data").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
    private var exportJSON: String {
        var fixture: [String: Any] = ["account": "Sample member", "fixture": true]
        if includeNotes { fixture["notes"] = ["Meet at the harbor at 9."] }
        if includeFavorites { fixture["favorites"] = ["Harbor walk", "Forest trail"] }
        guard let data = try? JSONSerialization.data(withJSONObject: fixture, options: [.prettyPrinted, .sortedKeys]) else { return "{}" }
        return String(decoding: data, as: UTF8.self)
    }
}
private struct SamplePrivacyDocument: FileDocument {
    static var readableContentTypes: [UTType] { [.json] }
    var text: String
    init(text: String) { self.text = text }
    init(configuration: ReadConfiguration) throws { text = String(decoding: configuration.file.regularFileContents ?? Data(), as: UTF8.self) }
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper { FileWrapper(regularFileWithContents: Data(text.utf8)) }
}

#Preview { NavigationStack { LocalAccountDataDemo() } }

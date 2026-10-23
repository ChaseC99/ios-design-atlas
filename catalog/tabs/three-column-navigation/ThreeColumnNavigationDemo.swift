import SwiftUI

struct ThreeColumnNavigationDemo: View {
    @State private var folder: String? = "Field notes"
    @State private var note: String?
    @State private var visibility: NavigationSplitViewVisibility = .all
    private let folders = ["Field notes", "Weekend plans", "Reading list"]
    private var notes: [String] {
        switch folder { case "Weekend plans": ["The coastal route", "A table for two", "Sunday morning"]
        case "Reading list": ["On noticing", "A place of your own", "Everyday rituals"]
        default: ["Quiet corners", "Open water", "Something worth keeping"] }
    }
    var body: some View {
        NavigationSplitView(columnVisibility: $visibility) {
            List(folders, id: \.self, selection: $folder) { folder in
                NavigationLink(value: folder) { Label(folder, systemImage: "folder") }
            }.navigationTitle("Notes").navigationSplitViewColumnWidth(min: 220, ideal: 260, max: 320)
        } content: {
            if let folder {
                List(notes, id: \.self, selection: $note) { note in
                    NavigationLink(value: note) {
                        VStack(alignment: .leading, spacing: 6) {
                            Text(note).font(.headline)
                            Text("Updated today · Personal").font(.caption).foregroundStyle(.secondary)
                        }.padding(.vertical, 8)
                    }
                }.navigationTitle(folder).navigationSplitViewColumnWidth(min: 260, ideal: 320, max: 380)
            } else {
                ContentUnavailableView("Choose a folder", systemImage: "folder")
            }
        } detail: {
            if let note {
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        Text(note).font(.system(.largeTitle, design: .serif).weight(.semibold))
                        Text("There is a particular kind of quiet in the places we return to. Keep a little space for it.").font(.title3)
                        Text("PERSONAL · UPDATED TODAY").font(.caption.weight(.medium)).foregroundStyle(.secondary)
                    }.frame(maxWidth: 640, alignment: .leading).padding(32).frame(maxWidth: .infinity)
                }.navigationTitle(note).navigationBarTitleDisplayMode(.inline)
            } else {
                ContentUnavailableView("Choose a note", systemImage: "note.text", description: Text("Select a note to read it here."))
            }
        }
        .navigationSplitViewStyle(.balanced)
        .onChange(of: folder) { _, _ in note = nil }
        .accessibilityIdentifier("capture-ready")
    }
}

#Preview { ThreeColumnNavigationDemo() }

import SwiftUI

struct AccessibilityCustomActionsDemo: View {
    private struct Note: Identifiable { let id: String; var favorite = false }
    @State private var notes = [Note(id: "A quieter morning"), Note(id: "Places to return to"), Note(id: "A little further from home")]
    @State private var status = ""
    var body: some View {
        List {
            Section("Your notes") {
                ForEach(notes) { note in
                    HStack(spacing: 14) {
                        Image(systemName: "note.text").font(.title2).foregroundStyle(.indigo).accessibilityHidden(true)
                        VStack(alignment: .leading, spacing: 6) {
                            Text(note.id).font(.headline)
                            Text("Personal · Today").font(.caption).foregroundStyle(.secondary)
                        }
                        Spacer()
                        if note.favorite { Image(systemName: "star.fill").foregroundStyle(.orange).accessibilityHidden(true) }
                    }.padding(.vertical, 14)
                        .accessibilityElement(children: .ignore)
                        .accessibilityLabel(note.id)
                        .accessibilityValue(note.favorite ? "Favorite" : "Not a favorite")
                        .accessibilityActions {
                            Button(note.favorite ? "Remove favorite" : "Add favorite") { favorite(note.id) }
                            Button("Archive") { archive(note.id) }
                        }
                        .swipeActions(edge: .leading) { Button("Favorite", systemImage: "star") { favorite(note.id) }.tint(.orange) }
                        .swipeActions { Button("Archive", systemImage: "archivebox") { archive(note.id) }.tint(.indigo) }
                }
            }
            if !status.isEmpty { Section { Text(status).foregroundStyle(.secondary) } }
        }
        .overlay { if notes.isEmpty { ContentUnavailableView("All clear", systemImage: "tray") } }
        .navigationTitle("Accessible actions").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
    private func favorite(_ id: String) {
        guard let index = notes.firstIndex(where: { $0.id == id }) else { return }
        notes[index].favorite.toggle()
        status = notes[index].favorite ? "Added \(id) to favorites" : "Removed \(id) from favorites"
    }
    private func archive(_ id: String) { withAnimation { notes.removeAll { $0.id == id } }; status = "Archived \(id)" }
}

#Preview { NavigationStack { AccessibilityCustomActionsDemo() } }

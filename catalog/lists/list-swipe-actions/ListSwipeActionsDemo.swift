import SwiftUI

struct ListSwipeActionsDemo: View {
    private struct Note: Identifiable { let id: Int; let title: String; var pinned = false }
    @State private var notes = [Note(id: 0, title: "The scenic route"), Note(id: 1, title: "A quiet kind of morning"), Note(id: 2, title: "Places to return to"), Note(id: 3, title: "After the rain")]
    @State private var lastRemoved: (note: Note, index: Int)?
    @State private var allowFullSwipe = true
    private let isCapturing = ProcessInfo.processInfo.arguments.contains("--capture")
    var body: some View {
        List {
            if !isCapturing { Section { Toggle("Allow full swipe", isOn: $allowFullSwipe) } }
            Section("Saved notes") {
                ForEach(notes) { note in
                    HStack(spacing: 14) {
                        Image(systemName: "note.text").foregroundStyle(.indigo).frame(width: 38, height: 44)
                            .background(.indigo.opacity(0.08), in: .rect(cornerRadius: 10))
                        VStack(alignment: .leading, spacing: 6) {
                            Text(note.title).font(.headline)
                            Text("Personal · Today").font(.caption).foregroundStyle(.secondary)
                        }
                        Spacer()
                        if note.pinned { Image(systemName: "pin.fill").foregroundStyle(.orange) }
                    }.padding(.vertical, 12)
                        .swipeActions(edge: .leading, allowsFullSwipe: allowFullSwipe) {
                            Button(note.pinned ? "Unpin" : "Pin", systemImage: note.pinned ? "pin.slash" : "pin") {
                                if let index = notes.firstIndex(where: { $0.id == note.id }) { notes[index].pinned.toggle() }
                            }.tint(.orange)
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: allowFullSwipe) {
                            Button("Delete", systemImage: "trash", role: .destructive) { remove(note) }
                            Button("Archive", systemImage: "archivebox") { remove(note) }.tint(.indigo)
                        }
                }
            }
        }
        .overlay { if notes.isEmpty { ContentUnavailableView("All clear", systemImage: "tray", description: Text("Use Undo to bring back the last note.")) } }
        .safeAreaInset(edge: .bottom) {
            if lastRemoved != nil {
                HStack {
                    Text("Note removed").foregroundStyle(.secondary)
                    Spacer()
                    Button("Undo") {
                        if let removed = lastRemoved {
                            withAnimation { notes.insert(removed.note, at: min(removed.index, notes.count)); lastRemoved = nil }
                        }
                    }
                }.padding().background(.bar)
            }
        }
        .navigationTitle("Saved notes")
        .accessibilityIdentifier("capture-ready")
    }
    private func remove(_ note: Note) {
        guard let index = notes.firstIndex(where: { $0.id == note.id }) else { return }
        withAnimation { lastRemoved = (note, index); notes.remove(at: index) }
    }
}

#Preview { NavigationStack { ListSwipeActionsDemo() } }

import SwiftUI

struct ListAnimatedUpdatesDemo: View {
    private struct Note: Identifiable { let id: Int; var title: String; var expanded = false }
    @State private var notes = (1...12).map { Note(id: $0, title: ["A little room to wander", "The slower route", "Something worth keeping"][($0 - 1) % 3]) }
    @State private var nextID = 13
    @State private var showSaved = true
    private let isCapturing = ProcessInfo.processInfo.arguments.contains("--capture")
    var body: some View {
        List {
            if !isCapturing { Section { Toggle("Show saved section", isOn: $showSaved) } }
            if showSaved && !notes.isEmpty {
                Section("Saved · \(notes.count)") {
                    ForEach(notes) { note in
                        Button {
                            if let index = notes.firstIndex(where: { $0.id == note.id }) {
                                withAnimation(.snappy) { notes[index].expanded.toggle() }
                            }
                        } label: {
                            HStack(alignment: .top, spacing: 14) {
                                Image(systemName: ["leaf", "sun.horizon", "water.waves"][note.id % 3])
                                    .font(.title2).foregroundStyle([Color.teal, .orange, .indigo][note.id % 3])
                                    .frame(width: 50, height: 50).background(.quaternary, in: .rect(cornerRadius: 12))
                                VStack(alignment: .leading, spacing: 7) {
                                    Text(note.title).font(.headline)
                                    Text(note.expanded ? "Keep a little space for the unexpected. There is always something new to notice, even on a familiar path. A good day doesn't need a complicated plan." : "Personal · A note for another day")
                                        .font(.subheadline).foregroundStyle(.secondary)
                                        .lineLimit(note.expanded ? nil : 1)
                                }
                                Spacer(minLength: 0)
                                Image(systemName: note.expanded ? "chevron.up" : "chevron.down").font(.caption).foregroundStyle(.tertiary)
                            }.padding(.vertical, 10).contentShape(Rectangle())
                        }.buttonStyle(.plain)
                    }.onDelete { offsets in withAnimation { notes.remove(atOffsets: offsets) } }
                }
            }
        }
        .animation(.snappy, value: showSaved)
        .overlay {
            if notes.isEmpty || !showSaved {
                ContentUnavailableView("A little room for something new", systemImage: "tray", description: Text("Add a note to begin your collection."))
            }
        }
        .navigationTitle("Notes")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Add note", systemImage: "plus") {
                    withAnimation { notes.insert(Note(id: nextID, title: "A new beginning"), at: 0); nextID += 1; showSaved = true }
                }
            }
            ToolbarItem(placement: .bottomBar) {
                Button("Clear notes", systemImage: "trash", role: .destructive) { withAnimation { notes.removeAll() } }.disabled(notes.isEmpty)
            }
        }
        .accessibilityIdentifier("capture-ready")
    }
}

#Preview { NavigationStack { ListAnimatedUpdatesDemo() } }

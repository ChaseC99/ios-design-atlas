import SwiftUI

struct BatchEditingRecoveryDemo: View {
    private struct Note: Identifiable { let id: Int; let title: String; var folder = "Personal" }
    @State private var notes = [Note(id: 0, title: "Quiet mornings"), Note(id: 1, title: "Open water"), Note(id: 2, title: "The long way home"), Note(id: 3, title: "Something worth keeping")]
    @State private var selection: Set<Int> = [0, 1]
    @State private var removed: [Note] = []
    @State private var confirmDelete = false
    @State private var chooseFolder = false
    @State private var folder = "Travel"
    var body: some View {
        List(notes, selection: $selection) { note in
            VStack(alignment: .leading, spacing: 6) { Text(note.title).font(.headline); Text(note.folder).font(.caption).foregroundStyle(.secondary) }
                .padding(.vertical, 12).tag(note.id)
        }
        .environment(\.editMode, .constant(.active))
        .safeAreaInset(edge: .bottom) {
            VStack(spacing: 12) {
                if !removed.isEmpty { Button("Undo deletion") { notes.append(contentsOf: removed); notes.sort { $0.id < $1.id }; removed = [] } }
                HStack {
                    Text("\(selection.count) selected").foregroundStyle(.secondary)
                    Spacer()
                    Button("Move", systemImage: "folder") { chooseFolder = true }.disabled(selection.isEmpty)
                    Button("Delete", systemImage: "trash", role: .destructive) { confirmDelete = true }.disabled(selection.isEmpty)
                }
            }.padding().background(.bar)
        }
        .confirmationDialog("Delete \(selection.count) notes?", isPresented: $confirmDelete, titleVisibility: .visible) {
            Button("Delete Notes", role: .destructive) { removed = notes.filter { selection.contains($0.id) }; notes.removeAll { selection.contains($0.id) }; selection = [] }
        }
        .sheet(isPresented: $chooseFolder) {
            NavigationStack {
                Form {
                    Picker("Destination", selection: $folder) { Text("Travel").tag("Travel"); Text("Personal").tag("Personal"); Text("Ideas").tag("Ideas") }
                    Text("Move \(selection.count) selected notes.").foregroundStyle(.secondary)
                }.navigationTitle("Move notes").navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) { Button("Cancel") { chooseFolder = false } }
                        ToolbarItem(placement: .confirmationAction) { Button("Move") { for index in notes.indices where selection.contains(notes[index].id) { notes[index].folder = folder }; selection = []; chooseFolder = false } }
                    }
            }.presentationDetents([.medium])
        }
        .navigationTitle("Organize notes").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
}

#Preview { NavigationStack { BatchEditingRecoveryDemo() } }

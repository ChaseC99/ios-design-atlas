import SwiftUI

struct ToolbarActionRolesDemo: View {
    private let capturing = ProcessInfo.processInfo.arguments.contains("--capture")
    @State private var title = "A quiet weekend"
    @State private var draft = "A quiet weekend"
    @State private var notes = "Leave some space for the unexpected."
    @State private var draftNotes = "Leave some space for the unexpected."
    @State private var editing = false
    @State private var confirmDelete = false
    var body: some View {
        VStack(spacing: 24) {
            Image(systemName: "book.closed").font(.system(size: 64, weight: .light)).foregroundStyle(.orange)
            Text(title.isEmpty ? "No collection" : title).font(.system(.title, design: .serif))
            Button("Edit collection") { draft = title; draftNotes = notes; editing = true }.buttonStyle(.borderedProminent)
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationTitle("Collections").navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $editing) {
            NavigationStack {
                Form {
                    Section("Collection") {
                        TextField("Name", text: $draft)
                        TextField("Notes", text: $draftNotes, axis: .vertical).lineLimit(3...6)
                    }
                    Section { Label("Private collection", systemImage: "lock").foregroundStyle(.secondary) }
                }
                .navigationTitle("Edit collection").navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) { Button("Cancel", role: .cancel) { editing = false } }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Save") { title = draft.trimmingCharacters(in: .whitespacesAndNewlines); notes = draftNotes; editing = false }
                            .disabled(draft.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                    }
                    ToolbarItem(placement: .destructiveAction) {
                        Button("Delete", systemImage: "trash", role: .destructive) { confirmDelete = true }
                    }
                }
                .confirmationDialog("Delete collection?", isPresented: $confirmDelete, titleVisibility: .visible) {
                    Button("Delete collection", role: .destructive) { title = ""; editing = false }
                }
                .accessibilityIdentifier("capture-ready")
            }
        }
        .task { if capturing { editing = true } }
    }
}
#Preview { NavigationStack { ToolbarActionRolesDemo() } }

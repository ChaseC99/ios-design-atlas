import SwiftUI

struct DraftEditingFlowDemo: View {
    @State private var title = "A slower weekend"
    @State private var draft = "A slower weekend"
    @State private var notes = "A coastal walk, a little coffee, and no particular schedule."
    @State private var draftNotes = "A coastal walk, a little coffee, and no particular schedule."
    @State private var presented = false
    @State private var confirmDiscard = false
    private let isCapturing = ProcessInfo.processInfo.arguments.contains("--capture")
    private var dirty: Bool { draft != title || draftNotes != notes }
    var body: some View {
        Group {
            if isCapturing { Color(uiColor: .systemBackground).ignoresSafeArea() }
            else {
                Form {
                    Section("Collection") { Text(title).font(.headline); Text(notes).foregroundStyle(.secondary) }
                    Button("Edit collection") { draft = title; draftNotes = notes; presented = true }
                }
            }
        }
        .navigationTitle("Your collection")
        .sheet(isPresented: $presented) {
            NavigationStack {
                Form {
                    Section("Name") { TextField("Collection name", text: $draft) }
                    Section("Notes · optional") { TextField("Add a note", text: $draftNotes, axis: .vertical).lineLimit(3...6) }
                }
                .navigationTitle("Edit collection").navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) { Button("Cancel") { if dirty { confirmDiscard = true } else { presented = false } } }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Save") { title = draft.trimmingCharacters(in: .whitespacesAndNewlines); notes = draftNotes; presented = false }
                            .disabled(draft.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                    }
                }
                .confirmationDialog("Discard your changes?", isPresented: $confirmDiscard, titleVisibility: .visible) {
                    Button("Discard Changes", role: .destructive) { presented = false }
                    Button("Keep Editing", role: .cancel) { }
                }
                .interactiveDismissDisabled(dirty)
                .accessibilityIdentifier("capture-ready")
            }
        }
        .task { if isCapturing { presented = true } }
        .accessibilityIdentifier("capture-ready")
    }
}

#Preview { NavigationStack { DraftEditingFlowDemo() } }

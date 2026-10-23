import SwiftUI

struct SheetDismissalDemo: View {
    private let isCapturing = ProcessInfo.processInfo.arguments.contains("--capture")
    @State private var isPresented = false
    @State private var savedTitle = "The coastal path"
    @State private var savedNote = "Take the early trail and stop at the lighthouse."
    @State private var draftTitle = "The coastal path"
    @State private var draftNote = "Take the early trail and stop at the lighthouse."
    @State private var protectsChanges = true
    @State private var confirmDiscard = false

    private var hasChanges: Bool { draftTitle != savedTitle || draftNote != savedNote }

    private func openEditor() {
        draftTitle = savedTitle
        draftNote = savedNote
        isPresented = true
    }

    var body: some View {
        Group {
            if isCapturing {
                Color(uiColor: .systemBackground).ignoresSafeArea()
            } else {
                Form {
                    Section("Saved note") {
                        Text(savedTitle).font(.headline)
                        Text(savedNote).foregroundStyle(.secondary)
                    }
                    Toggle("Prevent swipe dismissal of unsaved edits", isOn: $protectsChanges)
                    Button("Edit note", action: openEditor)
                        .accessibilityIdentifier("present")
                }
            }
        }
        .navigationTitle("Dismissal and unsaved changes")
        .sheet(isPresented: $isPresented) {
            NavigationStack {
                Form {
                    Section("Title") { TextField("Title", text: $draftTitle) }
                    Section("Note") {
                        TextField("Add a note", text: $draftNote, axis: .vertical)
                            .lineLimit(4...8)
                    }
                    if hasChanges {
                        Label("Unsaved changes", systemImage: "pencil.circle")
                            .foregroundStyle(.secondary)
                    }
                }
                .navigationTitle("Edit field note")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            if hasChanges { confirmDiscard = true }
                            else { isPresented = false }
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Save") {
                            savedTitle = draftTitle
                            savedNote = draftNote
                            isPresented = false
                        }.disabled(draftTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                    }
                }
                .confirmationDialog("Discard your changes?", isPresented: $confirmDiscard, titleVisibility: .visible) {
                    Button("Discard changes", role: .destructive) { isPresented = false }
                    Button("Keep editing", role: .cancel) { }
                }
            }
            .interactiveDismissDisabled(protectsChanges && hasChanges)
            .accessibilityIdentifier("capture-ready")
        }
        .task { if isCapturing { openEditor() } }
    }
}

#Preview { NavigationStack { SheetDismissalDemo() } }

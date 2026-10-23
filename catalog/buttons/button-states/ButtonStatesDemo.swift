import SwiftUI

struct ButtonStatesDemo: View {
    @State private var isSaving = false
    @State private var saved = false
    @State private var pinned = true
    @State private var outcome = "Your draft is ready."
    @State private var saveTask: Task<Void, Never>?
    var body: some View {
        Form {
            Section("Save a draft") {
                Button {
                    isSaving = true
                    saveTask = Task {
                        do { try await Task.sleep(for: .seconds(1.2)) } catch { return }
                        saved = true
                        isSaving = false
                        outcome = "Draft saved."
                    }
                } label: {
                    HStack {
                        if isSaving { ProgressView() }
                        Label(isSaving ? "Saving…" : saved ? "Saved" : "Save draft", systemImage: saved ? "checkmark" : "square.and.arrow.down")
                    }.frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent).controlSize(.large).disabled(isSaving)
                Button("Export saved draft") { outcome = "Export prepared locally." }.disabled(!saved || isSaving)
            }
            Section("Selection") {
                Toggle(isOn: $pinned) { Label("Pinned", systemImage: "pin") }
                    .toggleStyle(.button)
            }
            Section("Action roles") {
                Button("Delete draft", role: .destructive) {
                    saveTask?.cancel(); isSaving = false; saved = false; outcome = "Demo draft deleted."
                }
                Button("Cancel changes", role: .cancel) {
                    saveTask?.cancel(); isSaving = false; outcome = "Changes cancelled."
                }
            }
            Section { Text(outcome).foregroundStyle(.secondary) }
        }
        .onDisappear { saveTask?.cancel() }
        .navigationTitle("Button states and roles")
        .navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }

}

#Preview { NavigationStack { ButtonStatesDemo() } }

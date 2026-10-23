import SwiftUI

struct ConfirmationDialogsDemo: View {
    @State private var isPresented = false
    @State private var showTitle = true
    @State private var outcome = "Original photo is unchanged"

    var body: some View {
        Form {
            Section {
                Label("Morning light", systemImage: "photo")
                Text("Choose an action for this saved photograph.")
                    .foregroundStyle(.secondary)
                Toggle("Show dialog title", isOn: $showTitle)
            } header: { Text("Selected item") }
            Section {
                Button("Photo actions") { isPresented = true }
                    .accessibilityIdentifier("present")
                    .confirmationDialog("What would you like to do?", isPresented: $isPresented,
                                        titleVisibility: showTitle ? .visible : .hidden) {
                        Button("Save a Copy") { outcome = "Copy saved" }
                        Button("Move to Collection") { outcome = "Moved to collection" }
                        Button("Delete Photo", role: .destructive) { outcome = "Photo deleted (demo only)" }
                        Button("Cancel", role: .cancel) { outcome = "Cancelled" }
                    } message: {
                        Text("Changes apply only to Morning light.")
                    }
            }
            Section("Outcome") { Text(outcome).accessibilityIdentifier("outcome") }
            Section("Adaptation") {
                Text("Open this on iPhone and iPad. In regular width, the system can anchor the dialog as a popover and handle cancellation by tapping outside.")
                    .foregroundStyle(.secondary)
            }
        }
        .navigationTitle("Confirmation dialogs")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview { NavigationStack { ConfirmationDialogsDemo() } }

import SwiftUI

struct AlertTextFieldsDemo: View {
    private let isCapturing = ProcessInfo.processInfo.arguments.contains("--capture")
    @State private var isPresented = false
    @State private var draft = "Weekend references"
    @State private var name = "Weekend references"
    @State private var outcome = "Ready to rename"

    var body: some View {
        Group {
            if isCapturing {
                Color(uiColor: .systemBackground).ignoresSafeArea()
            } else {
                interactiveDemo
            }
        }
        .alert("Rename collection", isPresented: $isPresented) {
            TextField("Collection name", text: $draft)
                .textInputAutocapitalization(.sentences)
                .accessibilityIdentifier("collection-name")
            Button("Save") {
                name = draft.trimmingCharacters(in: .whitespacesAndNewlines)
                outcome = "Saved"
            }
            .disabled(draft.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            .keyboardShortcut(.defaultAction)
            Button("Cancel", role: .cancel) { outcome = "Cancelled; original name kept" }
        } message: {
            Text("Give this collection a name you can find later.")
        }
        .navigationTitle("Alert text fields")
        .navigationBarTitleDisplayMode(.inline)
        .task { if isCapturing { isPresented = true } }
    }

    private var interactiveDemo: some View {
        Form {
            Section("Collection") {
                LabeledContent("Name", value: name)
                Button("Rename collection") {
                    draft = name
                    isPresented = true
                }
                .accessibilityIdentifier("present")
            }
            Section("Outcome") { Text(outcome).accessibilityIdentifier("outcome") }
            Section("Try it") {
                Text("Clear the field to disable Save. Edit and cancel to keep the original name. Use the keyboard to confirm a valid name.")
                    .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview { NavigationStack { AlertTextFieldsDemo() } }

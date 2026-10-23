import SwiftUI

struct AlertActionsDemo: View {
    private let isCapturing = ProcessInfo.processInfo.arguments.contains("--capture")
    @State private var isPresented = false
    @State private var actionCount = 2
    @State private var destructive = true
    @State private var outcome = "No action taken"

    var body: some View {
        Group {
            if isCapturing {
                Color(uiColor: .systemBackground).ignoresSafeArea()
            } else {
                interactiveDemo
            }
        }
        .alert(destructive ? "Delete this collection?" : "Save this collection?", isPresented: $isPresented) {
            Button(destructive ? "Delete" : "Save", role: destructive ? .destructive : nil) {
                outcome = destructive ? "Collection deleted (demo only)" : "Collection saved"
            }.keyboardShortcut(.defaultAction)
            if actionCount == 3 {
                Button("Keep a Copy") { outcome = "Copy kept" }
            }
            if actionCount > 1 {
                Button("Cancel", role: .cancel) { outcome = "Cancelled" }
            }
        } message: {
            Text("Your saved references will be affected. Choose an action to continue.")
        }
        .navigationTitle("Alert actions")
        .navigationBarTitleDisplayMode(.inline)
        .task { if isCapturing { isPresented = true } }
    }

    private var interactiveDemo: some View {
        Form {
            Section {
                Text("A short interruption for an important decision.")
                    .foregroundStyle(.secondary)
                Picker("Actions", selection: $actionCount) {
                    Text("One").tag(1)
                    Text("Two").tag(2)
                    Text("Three").tag(3)
                }.pickerStyle(.segmented)
                Toggle("Destructive primary action", isOn: $destructive)
            } header: { Text("Configuration") }
            Section {
                Button("Present alert") { isPresented = true }
                    .accessibilityIdentifier("present")
            }
            Section("Outcome") { Text(outcome).accessibilityIdentifier("outcome") }
            Section("Look closely") {
                Text("The system controls action placement. Compare one, two, and three actions, then try larger text in Settings.")
                    .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview { NavigationStack { AlertActionsDemo() } }

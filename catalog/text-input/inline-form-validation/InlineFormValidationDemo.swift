import SwiftUI

struct InlineFormValidationDemo: View {
    @State private var name = "Weekend notes"
    @State private var email = ProcessInfo.processInfo.arguments.contains("--capture") ? "avery@" : ""
    @State private var attempted = ProcessInfo.processInfo.arguments.contains("--capture")
    @State private var saved = false
    @FocusState private var focused: Bool
    private var emailValid: Bool {
        let parts = email.split(separator: "@", omittingEmptySubsequences: false)
        return parts.count == 2 && !parts[0].isEmpty && parts[1].contains(".") && !email.contains(where: \.isWhitespace)
    }
    private var nameValid: Bool { !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
    var body: some View {
        Form {
            Section("Collection name") {
                TextField("Required", text: $name)
                if attempted && !nameValid { Label("Enter a collection name", systemImage: "exclamationmark.circle").foregroundStyle(.red).font(.footnote) }
            }
            Section("Email address") {
                TextField("you@example.com", text: $email).textContentType(.emailAddress).keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never).autocorrectionDisabled().focused($focused)
                    .submitLabel(.done).onSubmit(save).accessibilityIdentifier("capture-focus")
                if attempted && !emailValid {
                    Label("Enter a complete email address, such as avery@example.com.", systemImage: "exclamationmark.circle")
                        .font(.footnote).foregroundStyle(.red).accessibilityIdentifier("validation-message")
                }
            }
            Section { Button(saved ? "Saved on this screen" : "Save collection", action: save) }
        }
        .navigationTitle("New collection").navigationBarTitleDisplayMode(.inline)
        .onChange(of: name) { _, _ in saved = false }.onChange(of: email) { _, _ in saved = false }
        .task { if ProcessInfo.processInfo.arguments.contains("--capture") { try? await Task.sleep(for: .milliseconds(400)); focused = true } }
        .accessibilityIdentifier("capture-ready")
    }
    private func save() { attempted = true; if nameValid && emailValid { saved = true; focused = false } }
}

#Preview { NavigationStack { InlineFormValidationDemo() } }

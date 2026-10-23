import SwiftUI

struct SecureFieldVisibilityDemo: View {
    private enum Field: Hashable { case hidden, visible }
    @State private var password = "weekend-atlas"
    @State private var visible = false
    @State private var saved = false
    @FocusState private var focus: Field?
    private let isCapturing = ProcessInfo.processInfo.arguments.contains("--capture")
    var body: some View {
        Form {
            Section {
                VStack(alignment: .leading, spacing: 12) {
                    Label("Your private collection", systemImage: "lock.shield").font(.headline)
                    Text("Choose a password for this local example.").foregroundStyle(.secondary)
                }.padding(.vertical, 12)
            }
            Section("Password") {
                HStack {
                    Group {
                        if visible {
                            TextField("Password", text: $password).focused($focus, equals: .visible)
                        } else {
                            SecureField("Password", text: $password).focused($focus, equals: .hidden)
                        }
                    }
                    .textContentType(.newPassword).textInputAutocapitalization(.never).autocorrectionDisabled()
                    .submitLabel(.done).onSubmit { focus = nil }
                    .accessibilityIdentifier("capture-focus")
                    Button(visible ? "Hide password" : "Show password", systemImage: visible ? "eye.slash" : "eye") {
                        let wasFocused = focus != nil
                        visible.toggle()
                        if wasFocused { focus = visible ? .visible : .hidden }
                    }.labelStyle(.iconOnly)
                }
            }
            Section {
                Button(saved ? "Password accepted" : "Use password") { saved = true; focus = nil }
                    .disabled(password.isEmpty)
            } footer: { Text("This demo does not create an account or send your entry anywhere.") }
        }
        .navigationTitle("Password").navigationBarTitleDisplayMode(.inline)
        .task { if isCapturing { try? await Task.sleep(for: .milliseconds(400)); focus = .hidden } }
        .accessibilityIdentifier("capture-ready")
    }
}

#Preview { NavigationStack { SecureFieldVisibilityDemo() } }

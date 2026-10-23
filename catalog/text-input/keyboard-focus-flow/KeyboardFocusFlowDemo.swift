import SwiftUI

struct KeyboardFocusFlowDemo: View {
    private enum Field: Int, CaseIterable { case name, email, website }
    @State private var name = "Avery Morgan"
    @State private var email = ""
    @State private var website = ""
    @State private var saved = false
    @FocusState private var field: Field?
    private let isCapturing = ProcessInfo.processInfo.arguments.contains("--capture")
    var body: some View {
        Form {
            Section("Profile") {
                TextField("Name", text: $name).textContentType(.name).focused($field, equals: .name)
                    .submitLabel(.next).onSubmit { field = .email }
                TextField("Email", text: $email).keyboardType(.emailAddress).textContentType(.emailAddress)
                    .textInputAutocapitalization(.never).autocorrectionDisabled().focused($field, equals: .email)
                    .submitLabel(.next).onSubmit { field = .website }.accessibilityIdentifier("capture-focus")
                TextField("Website (optional)", text: $website).keyboardType(.URL).textContentType(.URL)
                    .textInputAutocapitalization(.never).autocorrectionDisabled().focused($field, equals: .website)
                    .submitLabel(.done).onSubmit { field = nil }
            }
            Section { Button(saved ? "Profile saved" : "Save profile") { saved = true; field = nil }.keyboardShortcut("s", modifiers: .command) }
        }
        .navigationTitle("Edit profile").navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Button("Previous field", systemImage: "chevron.up") { move(-1) }.disabled(field == .name)
                Button("Next field", systemImage: "chevron.down") { move(1) }.disabled(field == .website)
                Spacer()
                Button("Done") { field = nil }
            }
        }
        .task { if isCapturing { try? await Task.sleep(for: .milliseconds(400)); field = .email } }
        .accessibilityIdentifier("capture-ready")
    }
    private func move(_ offset: Int) {
        let current = field?.rawValue ?? 0
        field = Field(rawValue: min(2, max(0, current + offset)))
    }
}

#Preview { NavigationStack { KeyboardFocusFlowDemo() } }

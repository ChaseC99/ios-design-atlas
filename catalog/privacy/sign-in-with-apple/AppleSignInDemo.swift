import SwiftUI
import AuthenticationServices

struct AppleSignInDemo: View {
    // Set true only in a target with the Sign in with Apple capability correctly provisioned.
    private let capabilityConfigured = false
    @State private var style = "Black"
    @State private var requestProfile = false
    @State private var status = "Authorization has not started"
    private var buttonStyle: SignInWithAppleButton.Style {
        switch style { case "White": .white; case "Outline": .whiteOutline; default: .black }
    }
    var body: some View {
        Form {
            Section {
                VStack(spacing: 20) {
                    Image(systemName: "person.crop.circle.badge.checkmark").font(.system(size: 62)).foregroundStyle(.teal)
                    Text("Your next chapter").font(.title.bold())
                    Text("Keep your places together.").foregroundStyle(.secondary)
                    SignInWithAppleButton(.continue) { request in
                        request.requestedScopes = requestProfile ? [.fullName, .email] : []
                    } onCompletion: { handle($0) }
                        .signInWithAppleButtonStyle(buttonStyle).frame(height: 50)
                        .disabled(!capabilityConfigured)
                }.padding(.vertical, 24)
            }
            Section("Button") {
                Picker("Style", selection: $style) { ForEach(["Black", "White", "Outline"], id: \.self) { Text($0) } }
                Toggle("Request name and email", isOn: $requestProfile)
            }
            Section("Target setup") {
                Label("Sign in with Apple capability required", systemImage: "wrench.and.screwdriver")
                Text("Enable and provision the capability, then turn on capabilityConfigured in this example. The catalog has no authentication backend.").font(.caption).foregroundStyle(.secondary)
                Text(status).font(.subheadline)
            }
        }
        .navigationTitle("Sign in with Apple").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
    private func handle(_ result: Result<ASAuthorization, Error>) {
        switch result {
        case .success: status = "Credential received · Backend verification required"
        case .failure(let error):
            status = (error as? ASAuthorizationError)?.code == .canceled ? "Sign-in cancelled" : "Sign-in failed · Check the target configuration"
        }
    }
}

#Preview { NavigationStack { AppleSignInDemo() } }

import SwiftUI
import AuthenticationServices

struct PasskeysPasswordsDemo: View {
    @Environment(\.authorizationController) private var authorization
    // Configure the associated domain and obtain a new server challenge before enabling requests.
    private let relyingParty: String? = nil
    private let challenge: Data? = nil
    @State private var username = "sample@example.com"
    @State private var password = ""
    @State private var status = "No authentication request made"
    @State private var pending = false
    var body: some View {
        Form {
            Section {
                VStack(spacing: 18) {
                    Image(systemName: "person.badge.key.fill").font(.system(size: 60)).foregroundStyle(.teal)
                    Text("Welcome back").font(.title.bold())
                    Button("Continue with a passkey", systemImage: "key") { requestPasskey() }
                        .buttonStyle(.borderedProminent)
                        .disabled(relyingParty == nil || challenge == nil || pending)
                }.frame(maxWidth: .infinity).padding(.vertical, 24)
            }
            Section("Password field preview") {
                TextField("Email", text: $username).textContentType(.username).keyboardType(.emailAddress).textInputAutocapitalization(.never).autocorrectionDisabled()
                SecureField("Password", text: $password).textContentType(.password)
                Button("Check fields locally") { status = "Fields are filled · No server request sent" }
                    .disabled(username.isEmpty || password.isEmpty)
            }
            Section("Service setup") {
                Text("Passkeys require your associated domain and a fresh server challenge. No credential service is connected to this catalog.").font(.caption).foregroundStyle(.secondary)
                Text(status).font(.subheadline)
            }
        }
        .navigationTitle("Passkeys and passwords").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
        .onDisappear { password = "" }
    }
    private func requestPasskey() {
        guard let relyingParty, let challenge else { return }
        pending = true
        Task {
            defer { pending = false }
            do {
                let provider = ASAuthorizationPlatformPublicKeyCredentialProvider(relyingPartyIdentifier: relyingParty)
                let result = try await authorization.performRequest(provider.createCredentialAssertionRequest(challenge: challenge))
                if case .passkeyAssertion = result { status = "Assertion received · Server verification still required" }
                else { status = "A different credential was returned" }
            } catch { status = (error as? ASAuthorizationError)?.code == .canceled ? "Passkey request cancelled" : "Passkey request failed" }
        }
    }
}

#Preview { NavigationStack { PasskeysPasswordsDemo() } }

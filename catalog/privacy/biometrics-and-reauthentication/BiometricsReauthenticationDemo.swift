import SwiftUI
import LocalAuthentication

struct BiometricsReauthenticationDemo: View {
    @Environment(\.scenePhase) private var scenePhase
    @State private var unlocked = false
    @State private var expired = false
    @State private var biometricsOnly = false
    @State private var context: LAContext?
    @State private var task: Task<Void, Never>?
    @State private var status = "Locked"
    private var configured: Bool { !(Bundle.main.object(forInfoDictionaryKey: "NSFaceIDUsageDescription") as? String ?? "").isEmpty }
    var body: some View {
        Form {
            Section {
                VStack(spacing: 20) {
                    Image(systemName: unlocked ? "lock.open.fill" : "lock.fill").font(.system(size: 60)).foregroundStyle(.teal)
                    Text(unlocked ? "Sample unlocked" : expired ? "Session expired" : "Private collection").font(.title.bold())
                    Text(unlocked ? "Harbor walk · Forest trail · Mountain lookout" : "Authenticate to reveal this local sample.")
                        .multilineTextAlignment(.center).foregroundStyle(.secondary)
                    Button(expired ? "Authenticate again" : "Unlock sample", systemImage: "faceid") { authenticate() }
                        .buttonStyle(.borderedProminent).disabled(!configured || unlocked || task != nil)
                    if task != nil { Button("Cancel authentication") { cancel() } }
                }.frame(maxWidth: .infinity).padding(.vertical, 24)
                Text(status).font(.subheadline).foregroundStyle(.secondary)
            }
            Section("Local session") {
                Toggle("Require biometrics", isOn: $biometricsOnly).disabled(task != nil)
                Button("Expire sample session") { cancel(); unlocked = false; expired = true; status = "Session expired · Authenticate again" }
                    .disabled(!unlocked)
            }
            if !configured {
                Section("Target setup") { Text("Add NSFaceIDUsageDescription before enabling device authentication. The simulator also needs an enrolled biometric configuration.").font(.caption).foregroundStyle(.secondary) }
            }
        }
        .navigationTitle("Biometrics and sessions").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
        .onChange(of: scenePhase) { _, phase in if phase == .background { cancel(); unlocked = false } }
        .onDisappear { cancel(); unlocked = false }
    }
    private func authenticate() {
        guard configured else { status = "Face ID usage description is missing"; return }
        let current = LAContext()
        let policy: LAPolicy = biometricsOnly ? .deviceOwnerAuthenticationWithBiometrics : .deviceOwnerAuthentication
        var error: NSError?
        guard current.canEvaluatePolicy(policy, error: &error) else { status = error?.localizedDescription ?? "Authentication unavailable"; return }
        context = current; status = "Waiting for authentication…"
        task = Task {
            do {
                let success = try await current.evaluatePolicy(policy, localizedReason: "Reveal the local Atlas sample collection.")
                guard !Task.isCancelled else { return }
                unlocked = success; expired = false; status = success ? "Device authentication succeeded" : "Authentication did not succeed"
            } catch {
                guard !Task.isCancelled else { return }
                switch (error as? LAError)?.code {
                case .userCancel, .appCancel, .systemCancel: status = "Authentication cancelled"
                case .biometryLockout: status = "Biometrics locked · Use the device passcode option"
                default: status = "Authentication failed or unavailable"
                }
            }
            task = nil; context = nil
        }
    }
    private func cancel() {
        guard task != nil else { return }
        task?.cancel(); context?.invalidate(); task = nil; context = nil; status = "Authentication cancelled"
    }
}

#Preview { NavigationStack { BiometricsReauthenticationDemo() } }

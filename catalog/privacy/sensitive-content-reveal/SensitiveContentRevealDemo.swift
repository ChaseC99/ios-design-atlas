import SwiftUI

struct SensitiveContentRevealDemo: View {
    @Environment(\.scenePhase) private var scenePhase
    @State private var revealed = false
    @State private var redactionPreview = false
    var body: some View {
        Form {
            Section {
                VStack(alignment: .leading, spacing: 24) {
                    HStack {
                        Label("Local sample", systemImage: "lock.shield.fill").foregroundStyle(.teal)
                        Spacer()
                        Text("DEMO").font(.caption.bold()).foregroundStyle(.secondary)
                    }
                    Text("Recovery reference").font(.title2.bold())
                    Text(revealed ? "SAMPLE 4821" : "•••••• ••••")
                        .font(.system(.title, design: .monospaced)).privacySensitive()
                        .accessibilityLabel(revealed && !redactionPreview ? "Sample recovery reference, 4821" : "Recovery reference hidden")
                        .redacted(reason: redactionPreview ? .privacy : [])
                    Button(revealed ? "Hide sample" : "Reveal sample", systemImage: revealed ? "eye.slash" : "eye") { revealed.toggle() }
                        .buttonStyle(.borderedProminent)
                }.padding(.vertical, 24)
            }
            Section("Privacy presentation") {
                Toggle("Preview privacy redaction", isOn: $redactionPreview)
                LabeledContent("Visible value", value: revealed && !redactionPreview ? "Revealed" : "Hidden")
                Text("The value hides when the app becomes inactive. This is a local fixture, not a real recovery code.").font(.caption).foregroundStyle(.secondary)
            }
        }
        .navigationTitle("Sensitive content").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
        .onChange(of: scenePhase) { _, phase in if phase != .active { revealed = false } }
    }
}

#Preview { NavigationStack { SensitiveContentRevealDemo() } }

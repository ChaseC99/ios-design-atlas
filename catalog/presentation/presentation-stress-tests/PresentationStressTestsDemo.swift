import SwiftUI

struct PresentationStressTestsDemo: View {
    @State private var isPresented = false
    @State private var useGerman = false
    @State private var longMessage = true
    @State private var outcome = "No action taken"

    var body: some View {
        Form {
            Section("Content stress") {
                Toggle("Long message", isOn: $longMessage)
                Toggle("German sample copy", isOn: $useGerman)
                Text("These are explicit sample translations. For full layout-direction testing, change the simulator language and region.")
                    .font(.footnote).foregroundStyle(.secondary)
            }
            Section {
                Button("Present stress test") { isPresented = true }
                    .accessibilityIdentifier("present")
                    .alert(useGerman ? "Änderungen an dieser Sammlung sichern?" : "Save changes to this shared collection?", isPresented: $isPresented) {
                        Button(useGerman ? "Änderungen sichern" : "Save Changes") { outcome = "Saved" }
                        Button(useGerman ? "Änderungen verwerfen" : "Discard Changes", role: .destructive) { outcome = "Discarded" }
                        Button(useGerman ? "Weiter bearbeiten" : "Keep Editing", role: .cancel) { outcome = "Kept editing" }
                    } message: {
                        Text(message)
                    }
            }
            Section("Outcome") { Text(outcome).accessibilityIdentifier("outcome") }
            Section("Accessibility checks") {
                Text("Try accessibility text sizes, Bold Text, VoiceOver, and a narrow display. Check the entire message and all actions remain reachable.")
                    .foregroundStyle(.secondary)
            }
        }
        .navigationTitle("Long text & accessibility")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var message: String {
        if useGerman {
            return longMessage
                ? "Du hast den Namen, die Beschreibung und die Reihenfolge dieser Sammlung geändert. Sichere deine Änderungen, damit sie beim nächsten Öffnen erhalten bleiben. Andere Personen sehen die neue Version erst nach dem Sichern."
                : "Deine Änderungen wurden noch nicht gesichert."
        }
        return longMessage
            ? "You changed the name, description, and order of this collection. Save your changes to keep them for the next time you open it. People you share with will see the updated version only after you save."
            : "Your changes have not been saved yet."
    }
}

#Preview { NavigationStack { PresentationStressTestsDemo() } }

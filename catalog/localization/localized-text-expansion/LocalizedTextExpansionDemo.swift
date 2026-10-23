import SwiftUI

struct LocalizedTextExpansionDemo: View {
    @State private var language = "de"
    @State private var notifications = true
    @State private var summaries = false
    @State private var saved = false
    private let isCapturing = ProcessInfo.processInfo.arguments.contains("--capture")
    private var labels: [String] {
        switch language {
        case "de": ["Einstellungen", "Benachrichtigungen", "Wöchentliche Zusammenfassung", "Datenschutzeinstellungen", "Änderungen speichern", "Später fortfahren"]
        case "fi": ["Asetukset", "Ilmoitukset", "Viikoittainen yhteenveto", "Tietosuoja-asetukset", "Tallenna muutokset", "Jatka myöhemmin"]
        default: ["Settings", "Notifications", "Weekly summary", "Privacy settings", "Save changes", "Continue later"]
        }
    }
    var body: some View {
        Form {
            if !isCapturing { Picker("Preview language", selection: $language) { Text("English").tag("en"); Text("Deutsch").tag("de"); Text("Suomi").tag("fi") } }
            Section {
                Toggle(isOn: $notifications) { Label(labels[1], systemImage: "bell").fixedSize(horizontal: false, vertical: true) }
                Toggle(isOn: $summaries) { Label(labels[2], systemImage: "calendar").fixedSize(horizontal: false, vertical: true) }
                NavigationLink { Text(labels[3]).font(.title).padding().navigationTitle(labels[3]) } label: {
                    Label(labels[3], systemImage: "hand.raised").fixedSize(horizontal: false, vertical: true)
                }
            }
            Section {
                ViewThatFits(in: .horizontal) {
                    HStack { actions }
                    VStack(alignment: .leading, spacing: 12) { actions }
                }.padding(.vertical, 8)
            }
            if saved { Section { Image(systemName: "checkmark.circle.fill").foregroundStyle(.green).accessibilityLabel(language == "de" ? "Gespeichert" : language == "fi" ? "Tallennettu" : "Saved") } }
        }
        .navigationTitle(labels[0])
        .environment(\.locale, Locale(identifier: language))
        .accessibilityIdentifier("capture-ready")
    }
    @ViewBuilder private var actions: some View {
        Button(labels[4]) { saved = true }.buttonStyle(.borderedProminent).fixedSize(horizontal: false, vertical: true)
        Button(labels[5]) { saved = false }.buttonStyle(.bordered).fixedSize(horizontal: false, vertical: true)
    }
}

#Preview { NavigationStack { LocalizedTextExpansionDemo() } }

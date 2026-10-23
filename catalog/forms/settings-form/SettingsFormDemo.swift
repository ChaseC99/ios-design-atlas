import SwiftUI

struct SettingsFormDemo: View {
    @State private var reminders = true
    @State private var summary = "Weekly"
    @State private var quietHours = true
    @State private var quietStart = Date(timeIntervalSince1970: 75600)
    @State private var preview = "When unlocked"
    var body: some View {
        Form {
            Section {
                Label("A little less noise.", systemImage: "bell.badge").font(.title2.weight(.semibold)).padding(.vertical, 14)
                Text("Choose what is worth an interruption.").foregroundStyle(.secondary)
            }
            Section("Reminders") {
                Toggle("Collection reminders", isOn: $reminders)
                if reminders {
                    Picker("Summary", selection: $summary) { Text("Daily").tag("Daily"); Text("Weekly").tag("Weekly"); Text("Never").tag("Never") }
                    Picker("Show previews", selection: $preview) { Text("Always").tag("Always"); Text("When unlocked").tag("When unlocked"); Text("Never").tag("Never") }
                }
            }
            Section {
                Toggle("Quiet hours", isOn: $quietHours)
                if quietHours { DatePicker("Begins at", selection: $quietStart, displayedComponents: .hourAndMinute) }
            } footer: { Text("These controls demonstrate local settings. They do not request notification access.") }
        }
        .environment(\.timeZone, TimeZone(secondsFromGMT: 0)!)
        .navigationTitle("Preferences")
        .accessibilityIdentifier("capture-ready")
    }
}

#Preview { NavigationStack { SettingsFormDemo() } }

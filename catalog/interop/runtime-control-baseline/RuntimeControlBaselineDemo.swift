import SwiftUI
import UIKit

struct RuntimeControlBaselineDemo: View {
    @State private var reminders = true
    @State private var frequency = "Weekly"
    @State private var copies = 2
    @State private var saved = false
    var body: some View {
        Form {
            Section {
                VStack(alignment: .leading, spacing: 10) {
                    Text("The familiar details.").font(.system(.title, design: .serif).bold())
                    Text("One source. Standard controls.").foregroundStyle(.secondary)
                }.padding(.vertical, 12)
            }
            Section("Preferences") {
                Toggle("Reminders", isOn: $reminders)
                Picker("Frequency", selection: $frequency) {
                    Text("Daily").tag("Daily"); Text("Weekly").tag("Weekly"); Text("Monthly").tag("Monthly")
                }
                Stepper("\(copies) copies", value: $copies, in: 1...5)
            }
            Section("Actions") {
                Button(saved ? "Saved to collection" : "Save to collection", systemImage: saved ? "checkmark" : "bookmark") { saved.toggle() }
                Menu("More options", systemImage: "ellipsis.circle") {
                    Button("Reset preferences") { reminders = true; frequency = "Weekly"; copies = 2; saved = false }
                    Button("Remove saved item", role: .destructive) { saved = false }.disabled(!saved)
                }
            }
            Section("Progress") { ProgressView(value: 0.65) { Text("Organizing ideas") } }
            Section { LabeledContent("Runtime", value: "iOS \(UIDevice.current.systemVersion)") }
        }
        .navigationTitle("Control baseline")
        .accessibilityIdentifier("capture-ready")
    }
}

#Preview { NavigationStack { RuntimeControlBaselineDemo() } }

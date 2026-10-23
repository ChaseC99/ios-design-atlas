import SwiftUI

struct ToggleStylesDemo: View {
    @State private var notifications = true
    @State private var favorite = true
    @State private var offline = false
    @State private var showDetails = true
    var body: some View {
        Form {
            Section("Switches") {
                Toggle("Notify me about changes", isOn: $notifications)
                Toggle(isOn: $offline) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Available offline")
                        Text("Keep this collection on your device.").font(.caption).foregroundStyle(.secondary)
                    }
                }
            }
            Section("Buttons") {
                HStack {
                    Toggle(isOn: $favorite) { Label("Favorite", systemImage: "star") }
                    Toggle(isOn: $showDetails) { Label("Details", systemImage: "info.circle") }
                }.toggleStyle(.button)
            }
            Section("Compact label") {
                HStack {
                    Label("Notifications", systemImage: "bell")
                    Spacer()
                    Toggle("Notifications", isOn: $notifications).labelsHidden()
                }
            }
            if showDetails {
                Section {
                    Label(favorite ? "Favorite collection" : "Standard collection", systemImage: favorite ? "star.fill" : "folder")
                    Text(offline ? "Ready for your next trip." : "Connect to open the full collection.").foregroundStyle(.secondary)
                }
            }
        }
        .navigationTitle("Toggles and labels")
        .navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }

}

#Preview { NavigationStack { ToggleStylesDemo() } }

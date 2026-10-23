import SwiftUI

struct ButtonLabelsDemo: View {
    @State private var saved = false
    @State private var longLabel = false
    private var title: String { longLabel ? "Save this collection for later" : "Save collection" }
    var body: some View {
        Form {
            Section("Label treatments") {
                Button { saved.toggle() } label: { Label(title, systemImage: "bookmark") }
                    .labelStyle(.titleAndIcon)
                Button { saved.toggle() } label: { Label(title, systemImage: "bookmark") }
                    .labelStyle(.titleOnly)
                Button { saved.toggle() } label: { Label(title, systemImage: "bookmark") }
                    .labelStyle(.iconOnly)
                    .frame(minWidth: 44, minHeight: 44)
                    .accessibilityLabel(title)
            }.buttonStyle(.bordered)
            Section("Available width") {
                Button { saved.toggle() } label: {
                    Label(title, systemImage: "bookmark").frame(maxWidth: .infinity)
                }.buttonStyle(.borderedProminent).controlSize(.large)
                Toggle("Long action label", isOn: $longLabel)
            }
            Section {
                Label(saved ? "Saved to your collection" : "Ready to save", systemImage: saved ? "checkmark.circle" : "bookmark")
                    .foregroundStyle(.secondary)
            }
        }
        .navigationTitle("Button labels and width")
        .navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }

}

#Preview { NavigationStack { ButtonLabelsDemo() } }

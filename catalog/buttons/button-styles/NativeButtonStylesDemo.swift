import SwiftUI

struct NativeButtonStylesDemo: View {
    @State private var outcome = "Ready"
    @State private var capsule = true
    var body: some View {
        Form {
            Section("Emphasis") {
                Button("Automatic") { outcome = "Automatic selected" }.buttonStyle(.automatic)
                Button("Plain") { outcome = "Plain selected" }.buttonStyle(.plain)
                Button("Borderless") { outcome = "Borderless selected" }.buttonStyle(.borderless)
                Button("Bordered") { outcome = "Bordered selected" }.buttonStyle(.bordered)
                Button("Prominent") { outcome = "Prominent selected" }.buttonStyle(.borderedProminent)
            }
            Section("Sizes") {
                HStack(alignment: .center, spacing: 16) {
                    Button("Small") { outcome = "Small selected" }.controlSize(.small)
                    Button("Regular") { outcome = "Regular selected" }.controlSize(.regular)
                    Button("Large") { outcome = "Large selected" }.controlSize(.large)
                }.buttonStyle(.bordered)
            }
            Section("Shape") {
                Toggle("Capsule border", isOn: $capsule)
                Button("Save collection") { outcome = "Collection saved" }
                    .buttonStyle(.borderedProminent).controlSize(.large)
                    .buttonBorderShape(capsule ? .capsule : .roundedRectangle)
            }
            Section { Text(outcome).foregroundStyle(.secondary) }
        }
        .navigationTitle("Native button styles")
        .navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }

}

#Preview { NavigationStack { NativeButtonStylesDemo() } }

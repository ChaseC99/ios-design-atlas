import SwiftUI

struct ColorPickersDemo: View {
    @State private var color = Color.teal
    @State private var supportsOpacity = true
    var body: some View {
        Form {
            Section {
                VStack(alignment: .leading, spacing: 24) {
                    Image(systemName: "folder.fill").font(.system(size: 56)).foregroundStyle(color)
                    Text("Weekend references").font(.title2.bold())
                    Text("12 saved ideas").font(.subheadline).foregroundStyle(.secondary)
                }
                .padding(28)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(color.opacity(0.12), in: RoundedRectangle(cornerRadius: 24))
                .padding(.vertical, 12)
            }
            Section("Collection appearance") {
                ColorPicker("Collection color", selection: $color, supportsOpacity: supportsOpacity)
                Toggle("Allow opacity changes", isOn: $supportsOpacity)
                Button("Reset to teal") { color = .teal }
            }
        }
        .navigationTitle("Color pickers")
        .navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }

}

#Preview { NavigationStack { ColorPickersDemo() } }

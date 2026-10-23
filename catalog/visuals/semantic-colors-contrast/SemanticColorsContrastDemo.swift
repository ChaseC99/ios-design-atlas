import SwiftUI

struct SemanticColorsContrastDemo: View {
    private let capturing = ProcessInfo.processInfo.arguments.contains("--capture")
    @Environment(\.colorScheme) private var inheritedScheme
    @Environment(\.colorSchemeContrast) private var inheritedContrast
    @State private var dark = false
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 28) {
                VStack(alignment: .leading, spacing: 16) {
                    Image(systemName: "sun.max.fill").font(.largeTitle).foregroundStyle(.orange)
                    Text("A clear hierarchy.").font(.system(.largeTitle, design: .serif)).foregroundStyle(.primary)
                    Text("Supporting detail uses a secondary foreground.").font(.title3).foregroundStyle(.secondary)
                    Text("A small piece of metadata").font(.footnote).foregroundStyle(.tertiary)
                }.padding(26).frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(uiColor: .secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 28))
                HStack(spacing: 12) {
                    swatch("Blue", color: .blue); swatch("Green", color: .green); swatch("Orange", color: .orange)
                }
                if !capturing {
                    Toggle("Preview dark appearance", isOn: $dark)
                    LabeledContent("System contrast", value: inheritedContrast == .increased ? "Increased" : "Standard")
                    Text("Increase Contrast follows the system’s accessibility setting.").font(.caption).foregroundStyle(.secondary)
                }
            }.padding(24).frame(maxWidth: 640)
        }.background(Color(uiColor: .systemGroupedBackground))
        .environment(\.colorScheme, dark ? .dark : inheritedScheme)
        .navigationTitle("Semantic color").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
    private func swatch(_ title: String, color: Color) -> some View {
        VStack(spacing: 12) {
            RoundedRectangle(cornerRadius: 20).fill(color).frame(height: 100)
            Text(title).font(.caption).foregroundStyle(.secondary)
        }.frame(maxWidth: .infinity)
    }
}
#Preview { NavigationStack { SemanticColorsContrastDemo() } }

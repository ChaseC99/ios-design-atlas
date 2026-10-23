import SwiftUI

struct SymbolRenderingModesDemo: View {
    private let capturing = ProcessInfo.processInfo.arguments.contains("--capture")
    @State private var symbol = "cloud.sun.rain.fill"
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                row("Monochrome") { Image(systemName: symbol).symbolRenderingMode(.monochrome).foregroundStyle(.teal) }
                row("Hierarchical") { Image(systemName: symbol).symbolRenderingMode(.hierarchical).foregroundStyle(.teal) }
                row("Palette") { Image(systemName: symbol).symbolRenderingMode(.palette).foregroundStyle(.orange, .teal, .indigo) }
                row("Multicolor") { Image(systemName: symbol).symbolRenderingMode(.multicolor) }
                if !capturing {
                    Picker("Symbol", selection: $symbol) {
                        Text("Weather").tag("cloud.sun.rain.fill")
                        Text("Person").tag("person.crop.circle.fill")
                        Text("Folder").tag("folder.badge.plus")
                    }.pickerStyle(.segmented)
                }
            }.padding(28).frame(maxWidth: 600)
        }
        .navigationTitle("Layers of a symbol").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
    private func row<Content: View>(_ name: String, @ViewBuilder icon: () -> Content) -> some View {
        HStack(spacing: 28) {
            icon().font(.system(size: 48)).frame(width: 86, height: 76)
            Text(name).font(.title3)
            Spacer()
        }.padding(18).background(Color(uiColor: .secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 26))
    }
}
#Preview { NavigationStack { SymbolRenderingModesDemo() } }

import SwiftUI

struct SymbolVariantsAlignmentDemo: View {
    private let capturing = ProcessInfo.processInfo.arguments.contains("--capture")
    @State private var filled = false
    @State private var bold = false
    @State private var large = true
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {
                HStack(spacing: 26) {
                    Image(systemName: "heart")
                    Image(systemName: "heart").symbolVariant(.fill)
                    Image(systemName: "heart").symbolVariant(.circle)
                    Image(systemName: "heart").symbolVariant(.circle.fill)
                }.font(.system(size: 42, weight: .light)).foregroundStyle(.pink).frame(maxWidth: .infinity).padding(.vertical, 32)
                ForEach(["Books", "Places", "Favorites"], id: \.self) { title in
                    Label(title, systemImage: title == "Books" ? "book" : title == "Places" ? "mappin.circle" : "star")
                        .symbolVariant(filled ? .fill : .none)
                        .font(.title2.weight(bold ? .bold : .regular))
                        .imageScale(large ? .large : .medium)
                        .padding(20).frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.teal.opacity(0.06), in: RoundedRectangle(cornerRadius: 22))
                }
                HStack(alignment: .firstTextBaseline, spacing: 12) {
                    Image(systemName: "sun.max").imageScale(.large)
                    Text("A little light.")
                }.font(.system(.title, design: .serif)).foregroundStyle(.orange)
                if !capturing {
                    Toggle("Filled variants", isOn: $filled)
                    Toggle("Bold weight", isOn: $bold)
                    Toggle("Large symbol scale", isOn: $large)
                }
            }.padding(28).frame(maxWidth: 620)
        }
        .navigationTitle("Icons and type").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
}
#Preview { NavigationStack { SymbolVariantsAlignmentDemo() } }

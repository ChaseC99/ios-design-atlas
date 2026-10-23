import SwiftUI

struct FontDesignWeightWidthDemo: View {
    private let capturing = ProcessInfo.processInfo.arguments.contains("--capture")
    @State private var design = 1
    @State private var weight = 1
    @State private var width = 1
    private let designs: [Font.Design] = [.default, .serif, .rounded, .monospaced]
    private let weights: [Font.Weight] = [.light, .regular, .semibold, .bold]
    private let widths: [Font.Width] = [.condensed, .standard, .expanded]
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {
                Text("Make room\nfor wonder.")
                    .font(.system(.largeTitle, design: designs[design]).weight(weights[weight]).width(widths[width]))
                    .padding(.vertical, 24)
                ForEach(0..<4) { index in
                    VStack(alignment: .leading, spacing: 10) {
                        Text(["SYSTEM", "SERIF", "ROUNDED", "MONOSPACED"][index]).font(.caption2).tracking(2).foregroundStyle(.secondary)
                        Text("A small observation.").font(.system(.title2, design: designs[index]))
                    }
                }
                if !capturing {
                    Picker("Design", selection: $design) {
                        Text("System").tag(0); Text("Serif").tag(1); Text("Rounded").tag(2); Text("Mono").tag(3)
                    }.pickerStyle(.segmented)
                    Picker("Weight", selection: $weight) {
                        Text("Light").tag(0); Text("Regular").tag(1); Text("Semibold").tag(2); Text("Bold").tag(3)
                    }.pickerStyle(.segmented)
                    Picker("Width", selection: $width) {
                        Text("Condensed").tag(0); Text("Standard").tag(1); Text("Expanded").tag(2)
                    }.pickerStyle(.segmented)
                }
            }.padding(28).frame(maxWidth: 680)
        }
        .navigationTitle("Type character").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
}
#Preview { NavigationStack { FontDesignWeightWidthDemo() } }

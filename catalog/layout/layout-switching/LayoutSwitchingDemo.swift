import SwiftUI

struct LayoutSwitchingDemo: View {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var vertical = false
    @State private var spacing = 16.0
    private var layout: AnyLayout {
        vertical ? AnyLayout(VStackLayout(alignment: .leading, spacing: spacing))
                 : AnyLayout(HStackLayout(alignment: .top, spacing: spacing))
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {
                Text("A place for each idea").font(.title2.bold())
                layout {
                    LayoutCounterCard(title: "Coast", symbol: "water.waves", tint: .teal)
                    LayoutCounterCard(title: "Forest", symbol: "tree.fill", tint: .green)
                    LayoutCounterCard(title: "City", symbol: "building.2.fill", tint: .indigo)
                }
                .frame(maxWidth: .infinity, minHeight: 220, alignment: .topLeading)
                .animation(reduceMotion ? nil : .smooth(duration: 0.45), value: vertical)
                .animation(reduceMotion ? nil : .smooth, value: spacing)
                Toggle("Vertical arrangement", isOn: $vertical)
                Slider(value: $spacing, in: 8...24, step: 4) { Text("Spacing") }
            }.padding(24).frame(maxWidth: 680).frame(maxWidth: .infinity)
        }
        .navigationTitle("Switching layouts with AnyLayout")
        .navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
}

private struct LayoutCounterCard: View {
    let title: String
    let symbol: String
    let tint: Color
    @State private var count = 0
    var body: some View {
        Button { count += 1 } label: {
            VStack(alignment: .leading, spacing: 14) {
                Image(systemName: symbol).font(.title2)
                Text(title).font(.headline)
                Text("\(count) saved").font(.caption).monospacedDigit()
            }
            .padding(16).frame(maxWidth: .infinity, alignment: .leading)
            .foregroundStyle(tint).background(tint.opacity(0.12), in: RoundedRectangle(cornerRadius: 20))
        }.buttonStyle(.plain)
    }
}

#Preview { NavigationStack { LayoutSwitchingDemo() } }

import SwiftUI

// Concept inspiration: Sarun Wongpatcharapakorn, “SwiftUI Plain Button Style cannot tap on an Empty space” (2023-06-26).
// https://sarunw.com/posts/swiftui-plain-button-style-cannot-tap/
// Original catalog implementation; no article text or sample code is reproduced.
struct PlainButtonHitAreaDemo: View {
    @State private var contentTaps = 0
    @State private var rectangleTaps = 0
    var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            Text("Every little space.").font(.system(.largeTitle, design: .serif))
            VStack(alignment: .leading, spacing: 12) {
                Label("Content-only hit testing", systemImage: "1.circle").font(.headline)
                Button { contentTaps += 1 } label: {
                    row(symbol: "sparkle", count: contentTaps)
                }.buttonStyle(.plain)
                    .background(.indigo.opacity(0.07), in: .rect(cornerRadius: 22))
                    .overlay(RoundedRectangle(cornerRadius: 22).stroke(.indigo.opacity(0.3), style: StrokeStyle(lineWidth: 1, dash: [4, 4])).allowsHitTesting(false))
                    .accessibilityLabel("Content-only button").accessibilityValue("\(contentTaps) taps")
            }
            VStack(alignment: .leading, spacing: 12) {
                Label("Whole-row hit testing", systemImage: "2.circle").font(.headline)
                Button { rectangleTaps += 1 } label: {
                    row(symbol: "sparkle", count: rectangleTaps).contentShape(Rectangle())
                }.buttonStyle(.plain)
                    .background(.teal.opacity(0.08), in: .rect(cornerRadius: 22))
                    .overlay(RoundedRectangle(cornerRadius: 22).stroke(.teal.opacity(0.5)).allowsHitTesting(false))
                    .accessibilityLabel("Whole-row button").accessibilityValue("\(rectangleTaps) taps")
            }
            Text("Tap the open space between the symbol and counter.").font(.subheadline).foregroundStyle(.secondary)
            Button("Reset counts", systemImage: "arrow.counterclockwise") { contentTaps = 0; rectangleTaps = 0 }.buttonStyle(.bordered)
            Spacer()
        }.padding(28).frame(maxWidth: 700).frame(maxWidth: .infinity)
        .navigationTitle("Hit-area discovery").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
    private func row(symbol: String, count: Int) -> some View {
        HStack {
            Image(systemName: symbol).font(.system(size: 32, weight: .light)).foregroundStyle(.teal)
            Spacer(minLength: 70)
            VStack(alignment: .trailing, spacing: 5) {
                Text("\(count)").font(.title2.monospacedDigit())
                Text("taps").font(.caption).foregroundStyle(.secondary)
            }
        }.padding(24)
    }
}
#Preview { NavigationStack { PlainButtonHitAreaDemo() } }

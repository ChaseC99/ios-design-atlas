import SwiftUI

struct ContentSymbolTransitionsDemo: View {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var count = 12
    @State private var favorite = false
    @State private var bounces = 0
    @State private var previewReducedMotion = false
    private var reducesMotion: Bool { reduceMotion || previewReducedMotion }
    var body: some View {
        Form {
            Section("A changing number") {
                HStack(alignment: .firstTextBaseline, spacing: 10) {
                    Text(count, format: .number).font(.system(size: 52, weight: .semibold, design: .rounded)).monospacedDigit()
                        .contentTransition(.numericText(value: Double(count)))
                    Text("saved ideas").foregroundStyle(.secondary)
                }.padding(.vertical, 12)
                HStack {
                    Button("Add one") { withAnimation(reducesMotion ? nil : .snappy) { count += 1 } }
                    Button("Reset") { withAnimation(reducesMotion ? nil : .snappy) { count = 12 } }
                }.buttonStyle(.bordered)
            }
            Section("A changing symbol") {
                HStack(spacing: 24) {
                    if reducesMotion {
                        Image(systemName: favorite ? "heart.fill" : "heart").font(.system(size: 44)).foregroundStyle(.pink)
                    } else {
                        Image(systemName: favorite ? "heart.fill" : "heart").font(.system(size: 44)).foregroundStyle(.pink)
                            .contentTransition(.symbolEffect(.replace))
                            .symbolEffect(.bounce, value: bounces)
                    }
                    Text(favorite ? "Favorite" : "Not a favorite").font(.headline).contentTransition(.interpolate)
                }.padding(.vertical, 12)
                HStack {
                    Button("Change favorite") { withAnimation(reducesMotion ? nil : .smooth) { favorite.toggle() } }
                    Button("Bounce") { bounces += 1 }
                }.buttonStyle(.bordered)
            }
            Toggle("Preview reduced motion", isOn: $previewReducedMotion)
        }
        .navigationTitle("Text and symbol changes")
        .navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }

}

#Preview { NavigationStack { ContentSymbolTransitionsDemo() } }

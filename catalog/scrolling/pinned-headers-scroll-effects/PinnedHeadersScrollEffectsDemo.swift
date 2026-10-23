import SwiftUI

struct PinnedHeadersScrollEffectsDemo: View {
    private let capturing = ProcessInfo.processInfo.arguments.contains("--capture")
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var effects = true
    private let sections = ["Morning", "Afternoon", "Evening"]
    var body: some View {
        let animate = effects && !reduceMotion
        ScrollView {
            LazyVStack(spacing: 18, pinnedViews: [.sectionHeaders]) {
                ForEach(0..<3) { section in
                    Section {
                        ForEach(0..<5) { index in
                            VStack(alignment: .leading, spacing: 54) {
                                Image(systemName: ["sun.max", "cloud.sun", "moon.stars"][section])
                                    .font(.system(size: 50, weight: .ultraLight))
                                Text("\(sections[section]) study \(index + 1)").font(.title2.weight(.medium))
                            }.frame(maxWidth: .infinity, alignment: .leading).padding(28)
                                .foregroundStyle(.white).background([Color.orange, .teal, .indigo][section].gradient, in: RoundedRectangle(cornerRadius: 28))
                                .scrollTransition { effect, phase in
                                    effect.opacity(!animate || phase.isIdentity ? 1 : 0.55)
                                        .scaleEffect(!animate || phase.isIdentity ? 1 : 0.93)
                                }
                        }
                    } header: {
                        HStack {
                            Text(sections[section]).font(.title3.bold())
                            Spacer()
                            Text("05 STUDIES").font(.caption2).tracking(1.5).foregroundStyle(.secondary)
                        }.padding(.vertical, 18).background(.regularMaterial)
                    }
                }
            }.padding(.horizontal, 24)
        }
        .navigationTitle("Passing light").navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if !capturing {
                ToolbarItem(placement: .topBarTrailing) {
                    Toggle("Scroll effects", systemImage: "sparkles", isOn: $effects)
                }
            }
        }
        .accessibilityIdentifier("capture-ready")
    }
}
#Preview { NavigationStack { PinnedHeadersScrollEffectsDemo() } }

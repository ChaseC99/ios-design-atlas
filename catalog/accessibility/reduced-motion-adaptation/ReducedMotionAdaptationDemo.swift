import SwiftUI

struct ReducedMotionAdaptationDemo: View {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var previewReduced = false
    @State private var expanded = true
    @State private var saved = false
    private let isCapturing = ProcessInfo.processInfo.arguments.contains("--capture")
    private var reduced: Bool { reduceMotion || previewReduced }
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                if !isCapturing { Toggle("Preview reduced motion", isOn: $previewReduced) }
                VStack(alignment: .leading, spacing: 22) {
                    Image(systemName: saved ? "bookmark.fill" : "bookmark").font(.system(size: 44)).foregroundStyle(.indigo).accessibilityHidden(true)
                    Text("A little inspiration\nfor another day.").font(.system(.largeTitle, design: .serif).bold())
                    Button(expanded ? "Show less" : "Read more") {
                        withAnimation(reduced ? nil : .spring(response: 0.45, dampingFraction: 0.85)) { expanded.toggle() }
                    }
                    if expanded {
                        Text("Leave a little room for an unexpected turn. The best part of a familiar path is the chance to notice it again.")
                            .foregroundStyle(.secondary)
                            .transition(reduced ? .identity : .move(edge: .top).combined(with: .opacity))
                    }
                    Button(saved ? "Saved" : "Save for later", systemImage: saved ? "checkmark" : "bookmark") {
                        withAnimation(reduced ? nil : .easeInOut(duration: 0.2)) { saved.toggle() }
                    }.buttonStyle(.borderedProminent)
                }.padding(26).background(.background, in: .rect(cornerRadius: 28))
            }.padding(22)
        }
        .background(Color(uiColor: .systemGroupedBackground))
        .navigationTitle("A calmer transition").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
}

#Preview { NavigationStack { ReducedMotionAdaptationDemo() } }

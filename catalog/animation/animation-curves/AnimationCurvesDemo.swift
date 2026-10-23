import SwiftUI

struct AnimationCurvesDemo: View {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var moved = false
    @State private var curve = "Spring"
    @State private var duration = 0.75
    @State private var implicit = false
    @State private var previewReducedMotion = false
    private var reducesMotion: Bool { reduceMotion || previewReducedMotion }
    private var animation: Animation {
        switch curve {
        case "Smooth": .smooth(duration: duration)
        case "Ease in out": .easeInOut(duration: duration)
        case "Linear": .linear(duration: duration)
        default: .spring(duration: duration, bounce: 0.35)
        }
    }
    var body: some View {
        Form {
            Section {
                movingCard
                Button(moved ? "Move back" : "Move across") {
                    if implicit { moved.toggle() }
                    else { withAnimation(reducesMotion ? nil : animation) { moved.toggle() } }
                }.buttonStyle(.borderedProminent)
            }
            Section("Motion") {
                Picker("Curve", selection: $curve) {
                    ForEach(["Spring", "Smooth", "Ease in out", "Linear"], id: \.self) { Text($0) }
                }
                Slider(value: $duration, in: 0.25...1.5, step: 0.25) { Text("Duration") }
                LabeledContent("Duration", value: "\(duration.formatted()) s")
                Toggle("Value-scoped animation", isOn: $implicit)
                Toggle("Preview reduced motion", isOn: $previewReducedMotion)
            }
        }
        .navigationTitle("Springs and timing curves")
        .navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }

    @ViewBuilder private var movingCard: some View {
        if implicit {
            card.animation(reducesMotion ? nil : animation, value: moved)
        } else {
            card
        }
    }

    private var card: some View {
        RoundedRectangle(cornerRadius: 24).fill(.teal.gradient)
            .frame(width: 80, height: 80)
            .overlay { Image(systemName: "leaf.fill").font(.title).foregroundStyle(.white) }
            .offset(x: moved ? 90 : -90)
            .frame(maxWidth: .infinity, minHeight: 200)
    }
}

#Preview { NavigationStack { AnimationCurvesDemo() } }

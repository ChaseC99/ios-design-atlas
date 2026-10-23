import SwiftUI

private struct AtlasMotionValues {
    var scale = 1.0
    var offset = 0.0
}

struct PhaseKeyframeDemo: View {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var phaseTrigger = 0
    @State private var keyframeTrigger = 0
    @State private var previewReducedMotion = false
    private var reducesMotion: Bool { reduceMotion || previewReducedMotion }

    var body: some View {
        Form {
            Section("A sequence of phases") {
                Group {
                    if reducesMotion {
                        leaf
                    } else {
                        leaf.phaseAnimator([0, 1, 2], trigger: phaseTrigger) { content, phase in
                            content.scaleEffect(phase == 1 ? 1.25 : 1)
                                .rotationEffect(.degrees(phase == 2 ? 12 : 0))
                        } animation: { _ in .spring(duration: 0.35, bounce: 0.25) }
                    }
                }.frame(maxWidth: .infinity, minHeight: 150)
                Button("Play phases") { phaseTrigger += 1 }.buttonStyle(.bordered)
            }
            Section("Independent keyframe tracks") {
                Group {
                    if reducesMotion {
                        sun
                    } else {
                        KeyframeAnimator(initialValue: AtlasMotionValues(), trigger: keyframeTrigger) { value in
                            sun.scaleEffect(value.scale).offset(y: value.offset)
                        } keyframes: { _ in
                            KeyframeTrack(\.scale) {
                                SpringKeyframe(1.2, duration: 0.3)
                                SpringKeyframe(1, duration: 0.35)
                            }
                            KeyframeTrack(\.offset) {
                                CubicKeyframe(-24, duration: 0.3)
                                CubicKeyframe(0, duration: 0.35)
                            }
                        }
                    }
                }.frame(maxWidth: .infinity, minHeight: 150)
                Button("Play keyframes") { keyframeTrigger += 1 }.buttonStyle(.bordered)
            }
            Toggle("Preview reduced motion", isOn: $previewReducedMotion)
        }
        .navigationTitle("Phase and keyframe animation")
        .navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
    private var leaf: some View { Image(systemName: "leaf.fill").font(.system(size: 64)).foregroundStyle(.green) }
    private var sun: some View { Image(systemName: "sun.max.fill").font(.system(size: 64)).foregroundStyle(.orange) }
}

#Preview { NavigationStack { PhaseKeyframeDemo() } }

import SwiftUI

struct GestureDrivenMotionDemo: View {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var offset = CGSize.zero
    @State private var previewReducedMotion = false
    private var reducesMotion: Bool { reduceMotion || previewReducedMotion }
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 28) {
                ZStack {
                    RoundedRectangle(cornerRadius: 28).fill(.secondary.opacity(0.06))
                    RoundedRectangle(cornerRadius: 24).strokeBorder(.teal.opacity(0.25), style: StrokeStyle(lineWidth: 2, dash: [6]))
                        .frame(width: 180, height: 160)
                    VStack(alignment: .leading, spacing: 20) {
                        Image(systemName: "paperplane.fill").font(.largeTitle)
                        Text("A small adventure").font(.headline)
                    }
                    .foregroundStyle(.white).padding(24).frame(width: 180, height: 160, alignment: .leading)
                    .background(.teal.gradient, in: RoundedRectangle(cornerRadius: 24))
                    .rotationEffect(.degrees(reducesMotion ? 0 : Double(offset.width) / 12))
                    .offset(offset)
                    .gesture(DragGesture()
                        .onChanged { value in
                            offset = CGSize(width: min(64, max(-64, value.translation.width)),
                                            height: min(70, max(-70, value.translation.height)))
                        }
                        .onEnded { _ in
                            withAnimation(reducesMotion ? nil : .spring(duration: 0.55, bounce: 0.3)) { offset = .zero }
                        })
                    .accessibilityLabel("Adventure card")
                    .accessibilityHint("Drag to move, then release to return to the center.")
                }.frame(height: 330)
                Text("Drag the card, then let it go.").font(.title2.bold())
                Toggle("Preview reduced motion", isOn: $previewReducedMotion)
                Button("Return to center") {
                    withAnimation(reducesMotion ? nil : .spring(duration: 0.55)) { offset = .zero }
                }.buttonStyle(.bordered)
            }.padding(24).frame(maxWidth: 600).frame(maxWidth: .infinity)
        }
        .navigationTitle("Gesture-driven motion")
        .navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }

}

#Preview { NavigationStack { GestureDrivenMotionDemo() } }

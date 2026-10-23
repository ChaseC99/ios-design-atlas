import SwiftUI

struct SimultaneousTransformsDemo: View {
    @State private var scale = 1.0
    @State private var angle = Angle.zero
    @GestureState private var liveScale = 1.0
    @GestureState private var liveAngle = Angle.zero
    private var displayedScale: Double { min(2, max(0.5, scale * liveScale)) }
    var body: some View {
        Form {
            Section {
                ZStack {
                    RoundedRectangle(cornerRadius: 24).fill(.teal.opacity(0.07))
                    VStack(spacing: 12) {
                        Image(systemName: "leaf.fill").font(.system(size: 70)).foregroundStyle(.teal)
                        Text("BOTANICAL").font(.caption.weight(.semibold)).tracking(3)
                    }
                    .padding(24)
                    .background(.background, in: .rect(cornerRadius: 18))
                    .scaleEffect(displayedScale)
                    .rotationEffect(angle + liveAngle)
                }
                .frame(height: 310).clipShape(.rect(cornerRadius: 24)).contentShape(.rect)
                .gesture(MagnifyGesture()
                    .updating($liveScale) { value, state, _ in state = value.magnification }
                    .onEnded { scale = min(2, max(0.5, scale * $0.magnification)) }
                    .simultaneously(with: RotateGesture()
                        .updating($liveAngle) { value, state, _ in state = value.rotation }
                        .onEnded { angle += $0.rotation }))
                .accessibilityElement(children: .ignore)
                .accessibilityLabel("Botanical artwork")
                .accessibilityValue("\(Int(displayedScale * 100)) percent, \(Int((angle + liveAngle).degrees)) degrees")
                .accessibilityAdjustableAction { direction in
                    resize(direction == .increment ? 0.1 : -0.1)
                }
                .accessibilityAction(named: "Rotate clockwise") { angle += .degrees(45) }
                LabeledContent("Scale", value: displayedScale.formatted(.percent.precision(.fractionLength(0))))
                LabeledContent("Rotation", value: "\(Int((angle + liveAngle).degrees))°")
            }
            Section("Adjust") {
                HStack {
                    Button("Smaller", systemImage: "minus.magnifyingglass") { resize(-0.1) }
                    Spacer()
                    Button("Larger", systemImage: "plus.magnifyingglass") { resize(0.1) }
                }.buttonStyle(.borderless)
                Button("Rotate 45°", systemImage: "rotate.right") { angle += .degrees(45) }
                Button("Reset") { scale = 1; angle = .zero }
            }
        }
        .navigationTitle("Magnify and rotate").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
    private func resize(_ amount: Double) { scale = min(2, max(0.5, scale + amount)) }
}

#Preview { NavigationStack { SimultaneousTransformsDemo() } }

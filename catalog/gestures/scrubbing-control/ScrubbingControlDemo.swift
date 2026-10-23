import SwiftUI

struct ScrubbingControlDemo: View {
    @State private var position = 0.38
    @GestureState private var preview: Double?
    private var shown: Double { preview ?? position }
    private let duration = 252.0
    var body: some View {
        Form {
            Section {
                VStack(spacing: 24) {
                    Image(systemName: "waveform").font(.system(size: 74)).foregroundStyle(.teal)
                        .frame(maxWidth: .infinity, minHeight: 200)
                        .background(.teal.opacity(0.08), in: .rect(cornerRadius: 24))
                    VStack(spacing: 6) {
                        Text("Between the tides").font(.title2.bold())
                        Text("Field recordings · Preview").font(.subheadline).foregroundStyle(.secondary)
                    }
                    GeometryReader { geometry in
                        let width = max(1, geometry.size.width - 24)
                        ZStack(alignment: .leading) {
                            Capsule().fill(.teal.opacity(0.14)).frame(height: 8)
                            Capsule().fill(.teal).frame(width: 12 + width * shown, height: 8)
                            Circle().fill(.teal).frame(width: 24, height: 24).offset(x: width * shown)
                        }
                        .frame(height: 44).contentShape(.rect)
                        .gesture(DragGesture(minimumDistance: 0)
                            .updating($preview) { value, state, _ in state = bounded((value.location.x - 12) / width) }
                            .onEnded { position = bounded(($0.location.x - 12) / width) })
                    }.frame(height: 44)
                    .accessibilityElement()
                    .accessibilityLabel("Preview position")
                    .accessibilityValue("\(time(shown * duration)) of \(time(duration))")
                    .accessibilityAdjustableAction { direction in step(direction == .increment ? 10 : -10) }
                    HStack {
                        Text(time(shown * duration))
                        Spacer()
                        Text("−" + time((1 - shown) * duration))
                    }.font(.caption.monospacedDigit()).foregroundStyle(.secondary)
                }.padding(.vertical)
            }
            Section {
                HStack {
                    Button("Back 10 seconds", systemImage: "gobackward.10") { step(-10) }
                    Spacer()
                    Button("Forward 10 seconds", systemImage: "goforward.10") { step(10) }
                }.buttonStyle(.borderless)
                LabeledContent("Position", value: preview == nil ? "Committed" : "Scrubbing")
                Button("Return to beginning") { position = 0 }
            }
        }
        .navigationTitle("Scrubbing").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
    private func bounded(_ value: Double) -> Double { min(1, max(0, value)) }
    private func step(_ seconds: Double) { position = bounded(position + seconds / duration) }
    private func time(_ seconds: Double) -> String {
        let value = Int(seconds)
        return "\(value / 60):\(String(format: "%02d", value % 60))"
    }
}

#Preview { NavigationStack { ScrubbingControlDemo() } }

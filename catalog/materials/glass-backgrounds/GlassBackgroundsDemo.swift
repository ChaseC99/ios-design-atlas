import SwiftUI

@available(iOS 26.0, *)
struct GlassBackgroundsDemo: View {
    private let capturing = ProcessInfo.processInfo.arguments.contains("--capture")
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var background = 2
    @State private var useClear = false
    @State private var moving = false
    @State private var saved = false
    var body: some View {
        ZStack {
            if moving && !reduceMotion && !capturing {
                TimelineView(.animation) { context in
                    canvas(phase: sin(context.date.timeIntervalSinceReferenceDate * 0.4) * 120)
                }
            } else { canvas(phase: 0) }
            VStack(spacing: 40) {
                Spacer()
                Button { saved.toggle() } label: {
                    Label(saved ? "Added to collection" : "Add to collection", systemImage: saved ? "checkmark" : "plus")
                        .font(.headline).padding(24)
                }
                .buttonStyle(.plain)
                .glassEffect((useClear ? Glass.clear : .regular).interactive())
                Spacer()
                if !capturing {
                    VStack(spacing: 16) {
                        Picker("Background", selection: $background) {
                            Text("Light").tag(0); Text("Dark").tag(1); Text("Pattern").tag(2)
                        }.pickerStyle(.segmented)
                        Toggle("Clear glass", isOn: $useClear)
                        Toggle("Move background", isOn: $moving).disabled(reduceMotion)
                    }.padding(24).background(.regularMaterial, in: RoundedRectangle(cornerRadius: 28))
                }
            }.padding(24)
        }
        .navigationTitle("Backgrounds").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
    private func canvas(phase: Double) -> some View {
        GeometryReader { geometry in
            ZStack {
                (background == 1 ? Color.black : Color.white)
                if background == 2 {
                    LinearGradient(colors: [.orange, .pink, .indigo], startPoint: .topLeading, endPoint: .bottomTrailing)
                    ForEach(0..<12) { index in
                        RoundedRectangle(cornerRadius: 22).fill(.white.opacity(0.22))
                            .frame(width: geometry.size.width * 1.6, height: 36)
                            .rotationEffect(.degrees(-30))
                            .offset(x: phase, y: CGFloat(index - 6) * 100)
                    }
                }
            }.frame(width: geometry.size.width, height: geometry.size.height).clipped()
        }.ignoresSafeArea().accessibilityHidden(true)
    }
}
#Preview { if #available(iOS 26.0, *) { NavigationStack { GlassBackgroundsDemo() } } }

import SwiftUI

struct ZoomPanArtworkDemo: View {
    @State private var scale: CGFloat = 1
    @GestureState private var magnification: CGFloat = 1
    @State private var offset: CGSize = .zero
    @GestureState private var drag: CGSize = .zero
    private var effectiveScale: CGFloat { min(4, max(1, scale * magnification)) }
    var body: some View {
        VStack(spacing: 20) {
            GeometryReader { proxy in
                ZStack {
                    LinearGradient(colors: [.indigo, .blue, .teal], startPoint: .topLeading, endPoint: .bottomTrailing)
                    ForEach(0..<7) { index in
                        Circle().stroke(.white.opacity(0.45), lineWidth: 2)
                            .frame(width: CGFloat(70 + index * 48), height: CGFloat(70 + index * 48))
                            .offset(x: 40, y: -50)
                    }
                    Text("TIDAL\nSTUDY").font(.system(size: 42, weight: .light, design: .serif)).foregroundStyle(.white)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading).padding(28)
                }
                .scaleEffect(effectiveScale)
                .offset(x: bounded(offset.width + drag.width, extent: proxy.size.width), y: bounded(offset.height + drag.height, extent: proxy.size.height))
                .frame(width: proxy.size.width, height: proxy.size.height).clipped().contentShape(Rectangle())
                .gesture(MagnifyGesture().updating($magnification) { value, state, _ in state = value.magnification }
                    .onEnded { value in scale = min(4, max(1, scale * value.magnification)); if scale == 1 { offset = .zero } })
                .simultaneousGesture(DragGesture().updating($drag) { value, state, _ in if scale > 1 { state = value.translation } }
                    .onEnded { value in
                        if scale > 1 {
                            offset.width = bounded(offset.width + value.translation.width, extent: proxy.size.width)
                            offset.height = bounded(offset.height + value.translation.height, extent: proxy.size.height)
                        }
                    })
                .onTapGesture(count: 2) { withAnimation(.snappy) { scale = scale == 1 ? 2 : 1; offset = .zero } }
                .accessibilityLabel("Tidal study artwork")
                .accessibilityAction(named: "Zoom in") { scale = min(4, scale + 1) }
                .accessibilityAction(named: "Reset zoom") { scale = 1; offset = .zero }
            }.aspectRatio(0.85, contentMode: .fit).clipShape(.rect(cornerRadius: 26))
            HStack {
                Text("\(effectiveScale, specifier: "%.1f")×").monospacedDigit().foregroundStyle(.secondary)
                Spacer()
                Button("Reset", systemImage: "arrow.counterclockwise") { withAnimation { scale = 1; offset = .zero } }
            }
            Spacer(minLength: 0)
        }.padding(24).frame(maxWidth: 650).frame(maxWidth: .infinity)
        .navigationTitle("Tidal study").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
    private func bounded(_ value: CGFloat, extent: CGFloat) -> CGFloat {
        let limit = extent * (effectiveScale - 1) / 2
        return min(limit, max(-limit, value))
    }
}
#Preview { NavigationStack { ZoomPanArtworkDemo() } }

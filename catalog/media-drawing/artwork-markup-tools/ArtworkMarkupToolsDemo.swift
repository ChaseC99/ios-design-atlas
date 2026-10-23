import SwiftUI

struct ArtworkMarkupToolsDemo: View {
    @State private var strokes = [Stroke(points: [CGPoint(x: 0.15, y: 0.64), CGPoint(x: 0.32, y: 0.48), CGPoint(x: 0.48, y: 0.59), CGPoint(x: 0.70, y: 0.36), CGPoint(x: 0.85, y: 0.46)], orange: true)]
    @State private var current: [CGPoint] = []
    @State private var orange = true
    @State private var squareCrop = false
    var body: some View {
        VStack(spacing: 20) {
            GeometryReader { proxy in
                ZStack {
                    LinearGradient(colors: [.indigo, .teal], startPoint: .top, endPoint: .bottom)
                    Circle().fill(.white.opacity(0.55)).frame(width: proxy.size.width * 0.4).offset(x: 60, y: -90)
                    Canvas { context, size in
                        for stroke in strokes { draw(stroke.points, color: stroke.orange ? .orange : .white, context: context, size: size) }
                        draw(current, color: orange ? .orange : .white, context: context, size: size)
                    }
                }.clipShape(.rect(cornerRadius: 24)).contentShape(Rectangle())
                .gesture(DragGesture(minimumDistance: 0)
                    .onChanged { value in current.append(CGPoint(x: value.location.x / proxy.size.width, y: value.location.y / proxy.size.height)) }
                    .onEnded { _ in if !current.isEmpty { strokes.append(Stroke(points: current, orange: orange)); current = [] } })
                .accessibilityLabel("Artwork annotation surface")
            }.aspectRatio(squareCrop ? 1 : 0.8, contentMode: .fit)
            HStack(spacing: 20) {
                Button("Undo stroke", systemImage: "arrow.uturn.backward") { if !strokes.isEmpty { strokes.removeLast() } }.disabled(strokes.isEmpty)
                Button(orange ? "Use white ink" : "Use orange ink", systemImage: "circle.fill") { orange.toggle() }.foregroundStyle(orange ? .orange : .primary)
                Spacer()
                Button(squareCrop ? "Portrait canvas" : "Square canvas", systemImage: squareCrop ? "rectangle.portrait" : "square") { squareCrop.toggle() }
                Button("Clear annotations", systemImage: "trash") { strokes = []; current = [] }.disabled(strokes.isEmpty)
            }.labelStyle(.iconOnly).buttonStyle(.bordered).controlSize(.large)
            Text("\(strokes.count) annotations · Original vector artwork").font(.footnote).foregroundStyle(.secondary)
            Spacer(minLength: 0)
        }.padding(24).frame(maxWidth: 650).frame(maxWidth: .infinity)
        .navigationTitle("Markup studio").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
    private func draw(_ points: [CGPoint], color: Color, context: GraphicsContext, size: CGSize) {
        guard let first = points.first else { return }
        var path = Path(); path.move(to: CGPoint(x: first.x * size.width, y: first.y * size.height))
        for point in points.dropFirst() { path.addLine(to: CGPoint(x: point.x * size.width, y: point.y * size.height)) }
        context.stroke(path, with: .color(color), style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
    }
    private struct Stroke { var points: [CGPoint]; var orange: Bool }
}
#Preview { NavigationStack { ArtworkMarkupToolsDemo() } }

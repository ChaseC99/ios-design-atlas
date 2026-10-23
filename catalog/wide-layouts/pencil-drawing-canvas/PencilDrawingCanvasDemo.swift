import SwiftUI
import PencilKit

struct PencilDrawingCanvasDemo: View {
    @State private var drawing = Self.sampleDrawing()
    @State private var erasing = false
    @State private var blue = false
    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text("Field notes").font(.system(.largeTitle, design: .serif))
                    Text("A small study of the coast").foregroundStyle(.secondary)
                }
                Spacer()
                Menu {
                    Button("Clear drawing", systemImage: "trash", role: .destructive) { drawing = PKDrawing() }
                    Button("Restore sample", systemImage: "arrow.counterclockwise") { drawing = Self.sampleDrawing() }
                } label: { Label("Drawing actions", systemImage: "ellipsis.circle") }.labelStyle(.iconOnly).font(.title2)
            }
            CanvasSurface(drawing: $drawing, erasing: erasing, blue: blue)
                .frame(minHeight: 340, maxHeight: 500)
                .background(Color(uiColor: .secondarySystemBackground), in: .rect(cornerRadius: 24))
                .clipShape(.rect(cornerRadius: 24))
                .overlay(RoundedRectangle(cornerRadius: 24).stroke(.quaternary))
                .accessibilityLabel("Drawing canvas")
            HStack(spacing: 18) {
                Button("Pen", systemImage: "pencil.tip") { erasing = false }
                    .tint(erasing ? .secondary : .accentColor)
                Button("Eraser", systemImage: "eraser") { erasing = true }
                    .tint(erasing ? .accentColor : .secondary)
                Spacer()
                Button(blue ? "Use orange ink" : "Use blue ink", systemImage: "circle.fill") { blue.toggle(); erasing = false }
                    .foregroundStyle(blue ? .blue : .orange)
            }.buttonStyle(.bordered).labelStyle(.iconOnly).controlSize(.large)
            Text("\(drawing.strokes.count) strokes").font(.footnote.monospacedDigit()).foregroundStyle(.secondary)
            Spacer(minLength: 0)
        }
        .padding(24).frame(maxWidth: 660).frame(maxWidth: .infinity)
        .navigationTitle("Sketchbook").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
    private static func sampleDrawing() -> PKDrawing {
        func stroke(_ points: [CGPoint], color: UIColor, width: CGFloat) -> PKStroke {
            let controlPoints = points.enumerated().map { index, point in
                PKStrokePoint(location: point, timeOffset: Double(index) * 0.03,
                              size: CGSize(width: width, height: width), opacity: 1,
                              force: 1, azimuth: 0, altitude: .pi / 2)
            }
            return PKStroke(ink: PKInk(.pen, color: color), path: PKStrokePath(controlPoints: controlPoints, creationDate: Date(timeIntervalSince1970: 0)))
        }
        let sun = (0...48).map { index in
            let angle = Double(index) / 48 * .pi * 2
            return CGPoint(x: 208 + cos(angle) * 28, y: 94 + sin(angle) * 28)
        }
        let ridge = [CGPoint(x: 25, y: 210), CGPoint(x: 75, y: 153), CGPoint(x: 126, y: 204), CGPoint(x: 174, y: 164), CGPoint(x: 275, y: 218)]
        var waves: [[CGPoint]] = []
        for row in 0..<3 {
            var points: [CGPoint] = []
            for step in 0...36 {
                let x = 28.0 + Double(step) * 6.8
                let baseline = 252.0 + Double(row) * 18.0
                let y = baseline + sin(Double(step) / 4.0) * 5.0
                points.append(CGPoint(x: x, y: y))
            }
            waves.append(points)
        }
        return PKDrawing(strokes: [stroke(sun, color: .systemOrange, width: 4), stroke(ridge, color: .systemTeal, width: 5)] + waves.map { stroke($0, color: .systemTeal, width: 3) })
    }
    private struct CanvasSurface: UIViewRepresentable {
        @Binding var drawing: PKDrawing
        let erasing: Bool
        let blue: Bool
        func makeCoordinator() -> Coordinator { Coordinator(self) }
        func makeUIView(context: Context) -> PKCanvasView {
            let view = PKCanvasView()
            view.drawingPolicy = .anyInput
            view.backgroundColor = .clear
            view.isOpaque = false
            view.isScrollEnabled = false
            view.delegate = context.coordinator
            return view
        }
        func updateUIView(_ view: PKCanvasView, context: Context) {
            context.coordinator.parent = self
            if view.drawing != drawing { view.drawing = drawing }
            view.tool = erasing ? PKEraserTool(.vector) : PKInkingTool(.pen, color: blue ? .systemBlue : .systemOrange, width: 5)
        }
        final class Coordinator: NSObject, PKCanvasViewDelegate {
            var parent: CanvasSurface
            init(_ parent: CanvasSurface) { self.parent = parent }
            func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) { parent.drawing = canvasView.drawing }
        }
    }
}
#Preview { NavigationStack { PencilDrawingCanvasDemo() } }

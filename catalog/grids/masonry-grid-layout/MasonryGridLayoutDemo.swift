import SwiftUI

struct MasonryGridLayoutDemo: View {
    @State private var columns = 2
    private let isCapturing = ProcessInfo.processInfo.arguments.contains("--capture")
    var body: some View {
        ScrollView {
            AtlasMasonryLayout(columns: columns, spacing: 16) {
                ForEach(0..<15) { index in
                    VStack(alignment: .leading, spacing: 0) {
                        ZStack {
                            Rectangle().fill([Color.teal, .orange, .indigo, .pink, .blue][index % 5].gradient)
                            Image(systemName: ["leaf", "sun.horizon", "moon.stars", "sparkles", "water.waves"][index % 5])
                                .font(.system(size: 46)).foregroundStyle(.white.opacity(0.9))
                        }.frame(height: [150.0, 210, 125, 180, 160][index % 5])
                        VStack(alignment: .leading, spacing: 7) {
                            Text(["Slow days", "First light", "After dark", "Small wonders", "Open water"][index % 5]).font(.headline)
                            if index % 3 != 0 { Text("A little inspiration for another day.").font(.caption).foregroundStyle(.secondary) }
                        }.padding(15)
                    }.background(.background).clipShape(.rect(cornerRadius: 20))
                }
            }.padding(20)
        }
        .background(Color(uiColor: .systemGroupedBackground))
        .safeAreaInset(edge: .top) {
            if !isCapturing { Stepper("\(columns) columns", value: $columns, in: 1...4).padding().background(.bar) }
        }
        .animation(.snappy, value: columns)
        .navigationTitle("Inspiration")
        .accessibilityIdentifier("capture-ready")
    }
}

private struct AtlasMasonryLayout: Layout {
    var columns = 2
    var spacing: CGFloat = 16
    private func frames(width: CGFloat, subviews: Subviews) -> [CGRect] {
        let count = max(1, columns)
        let columnWidth = max(0, (width - spacing * CGFloat(count - 1)) / CGFloat(count))
        var heights = Array(repeating: CGFloat.zero, count: count)
        return subviews.map { view in
            let column = heights.indices.min { heights[$0] < heights[$1] } ?? 0
            let size = view.sizeThatFits(ProposedViewSize(width: columnWidth, height: nil))
            let frame = CGRect(x: CGFloat(column) * (columnWidth + spacing), y: heights[column], width: columnWidth, height: size.height)
            heights[column] = frame.maxY + spacing
            return frame
        }
    }
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let ideal = subviews.map { $0.sizeThatFits(.unspecified).width }.max() ?? 0
        let width = max(0, proposal.width ?? (ideal * CGFloat(max(1, columns)) + spacing * CGFloat(max(0, columns - 1))))
        return CGSize(width: width, height: frames(width: width, subviews: subviews).map(\.maxY).max() ?? 0)
    }
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        for (view, frame) in zip(subviews, frames(width: bounds.width, subviews: subviews)) {
            view.place(at: CGPoint(x: bounds.minX + frame.minX, y: bounds.minY + frame.minY), anchor: .topLeading, proposal: ProposedViewSize(frame.size))
        }
    }
}

#Preview { NavigationStack { MasonryGridLayoutDemo() } }

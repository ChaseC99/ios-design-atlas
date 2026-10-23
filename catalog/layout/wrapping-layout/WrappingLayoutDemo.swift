import SwiftUI

struct WrappingLayoutDemo: View {
    @State private var width = 320.0
    @State private var selected: Set<String> = ["Coast", "Quiet gardens"]
    private let places = ["Coast", "Forest trails", "Quiet gardens", "City walks", "Lakes", "Small mountain villages"]
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 28) {
                Text("Where next?").font(.largeTitle.bold())
                Text("Keep a few possibilities close.").foregroundStyle(.secondary)
                AtlasFlowLayout(spacing: 10) {
                    ForEach(places, id: \.self) { place in
                        Button {
                            if selected.contains(place) { selected.remove(place) }
                            else { selected.insert(place) }
                        } label: {
                            Text(place).padding(.horizontal, 16).padding(.vertical, 12)
                                .foregroundStyle(selected.contains(place) ? Color.white : Color.primary)
                                .background(selected.contains(place) ? Color.teal : Color.secondary.opacity(0.1), in: Capsule())
                        }
                        .buttonStyle(.plain)
                        .accessibilityAddTraits(selected.contains(place) ? .isSelected : [])
                    }
                }.frame(width: width, alignment: .leading)
                Slider(value: $width, in: 220...340, step: 20) { Text("Available width") }
                LabeledContent("Layout width", value: "\(Int(width)) pt")
            }.padding(24).frame(maxWidth: 640).frame(maxWidth: .infinity)
        }
        .navigationTitle("A custom wrapping layout")
        .navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
}

private struct AtlasFlowLayout: Layout {
    var spacing: CGFloat = 10
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        arrange(subviews, width: proposal.width).size
    }
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let result = arrange(subviews, width: bounds.width)
        for index in subviews.indices {
            subviews[index].place(at: CGPoint(x: bounds.minX + result.points[index].x,
                                              y: bounds.minY + result.points[index].y),
                                  anchor: .topLeading,
                                  proposal: ProposedViewSize(result.sizes[index]))
        }
    }
    private func arrange(_ subviews: Subviews, width: CGFloat?) -> (size: CGSize, points: [CGPoint], sizes: [CGSize]) {
        let ideal = subviews.map { $0.sizeThatFits(.unspecified) }
        let naturalWidth = ideal.reduce(0) { $0 + $1.width } + spacing * CGFloat(max(0, ideal.count - 1))
        let available = max(0, width?.isFinite == true ? width! : naturalWidth)
        var points: [CGPoint] = []
        var sizes: [CGSize] = []
        var x: CGFloat = 0
        var y: CGFloat = 0
        var rowHeight: CGFloat = 0
        for (index, view) in subviews.enumerated() {
            let size = view.sizeThatFits(ProposedViewSize(width: min(ideal[index].width, available), height: nil))
            if x > 0 && x + size.width > available {
                x = 0; y += rowHeight + spacing; rowHeight = 0
            }
            points.append(CGPoint(x: x, y: y)); sizes.append(size)
            x += size.width + spacing
            rowHeight = max(rowHeight, size.height)
        }
        return (CGSize(width: available, height: y + rowHeight), points, sizes)
    }
}

#Preview { NavigationStack { WrappingLayoutDemo() } }

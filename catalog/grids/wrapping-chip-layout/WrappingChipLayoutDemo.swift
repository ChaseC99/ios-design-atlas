import SwiftUI

struct WrappingChipLayoutDemo: View {
    @State private var selected: Set<String> = ["Coastal walks", "Bookshops", "Quiet mornings"]
    @State private var compact = false
    private let isCapturing = ProcessInfo.processInfo.arguments.contains("--capture")
    private let interests = ["Coastal walks", "Bookshops", "Good coffee", "Quiet mornings", "Art & design", "Open water", "Architecture", "Small adventures", "Gardens", "Live music", "Long lunches", "New perspectives"]
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Make it your kind\nof weekend.").font(.system(.largeTitle, design: .serif).weight(.semibold))
                    Text("A few things you enjoy. A little more room for discovery.").foregroundStyle(.secondary)
                }
                AtlasFlowLayout(spacing: compact ? 6 : 10) {
                    ForEach(interests, id: \.self) { interest in
                        Button {
                            if !selected.insert(interest).inserted { selected.remove(interest) }
                        } label: {
                            HStack(spacing: 6) {
                                if selected.contains(interest) { Image(systemName: "checkmark").font(.caption.weight(.bold)) }
                                Text(interest).font(.subheadline.weight(.medium))
                            }
                            .padding(.horizontal, 15).padding(.vertical, 12)
                            .foregroundStyle(selected.contains(interest) ? Color.white : .primary)
                            .background(selected.contains(interest) ? Color.indigo : Color(uiColor: .secondarySystemGroupedBackground), in: .capsule)
                        }.buttonStyle(.plain).accessibilityAddTraits(selected.contains(interest) ? .isSelected : [])
                    }
                }
                if !isCapturing { Toggle("Compact spacing", isOn: $compact) }
                Text("\(selected.count) interests selected").font(.subheadline).foregroundStyle(.secondary)
            }.padding(24)
        }
        .background(Color(uiColor: .systemGroupedBackground))
        .navigationTitle("Your interests").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
}

private struct AtlasFlowLayout: Layout {
    var spacing: CGFloat = 10
    private func frames(width: CGFloat, subviews: Subviews) -> [CGRect] {
        var x: CGFloat = 0, y: CGFloat = 0, rowHeight: CGFloat = 0
        return subviews.map { view in
            let size = view.sizeThatFits(ProposedViewSize(width: width, height: nil))
            if x > 0 && x + size.width > width { x = 0; y += rowHeight + spacing; rowHeight = 0 }
            let frame = CGRect(origin: CGPoint(x: x, y: y), size: size)
            x += size.width + spacing; rowHeight = max(rowHeight, size.height)
            return frame
        }
    }
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let idealWidth = subviews.reduce(CGFloat.zero) { $0 + $1.sizeThatFits(.unspecified).width } + spacing * CGFloat(max(0, subviews.count - 1))
        let width = max(0, proposal.width ?? idealWidth)
        return CGSize(width: width, height: frames(width: width, subviews: subviews).map(\.maxY).max() ?? 0)
    }
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        for (view, frame) in zip(subviews, frames(width: bounds.width, subviews: subviews)) {
            view.place(at: CGPoint(x: bounds.minX + frame.minX, y: bounds.minY + frame.minY), anchor: .topLeading, proposal: ProposedViewSize(frame.size))
        }
    }
}

#Preview { NavigationStack { WrappingChipLayoutDemo() } }

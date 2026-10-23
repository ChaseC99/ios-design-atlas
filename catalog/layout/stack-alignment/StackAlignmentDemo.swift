import SwiftUI

private enum MetricEdge: AlignmentID {
    static func defaultValue(in dimensions: ViewDimensions) -> CGFloat { dimensions[.trailing] }
}
private extension HorizontalAlignment {
    static let metricEdge = HorizontalAlignment(MetricEdge.self)
}

struct StackAlignmentDemo: View {
    @State private var alignBaselines = true
    @State private var spacing = 12.0

    var body: some View {
        Form {
            Section("A shared baseline") {
                HStack(alignment: alignBaselines ? .firstTextBaseline : .center, spacing: spacing) {
                    Image(systemName: "figure.walk").font(.title)
                    Text("4.8").font(.system(size: 52, weight: .semibold, design: .rounded))
                    Text("km").font(.title3).foregroundStyle(.secondary)
                }.padding(.vertical, 16)
            }
            Section("A shared value edge") {
                VStack(alignment: .metricEdge, spacing: 16) {
                    HStack(spacing: 16) {
                        Text("Distance").foregroundStyle(.secondary)
                        Text("4.8 km").bold().alignmentGuide(.metricEdge) { $0[.leading] }
                    }
                    HStack(spacing: 16) {
                        Text("Walking time").foregroundStyle(.secondary)
                        Text("1 hour").bold().alignmentGuide(.metricEdge) { $0[.leading] }
                    }
                    HStack(spacing: 16) {
                        Text("Elevation").foregroundStyle(.secondary)
                        Text("120 m").bold().alignmentGuide(.metricEdge) { $0[.leading] }
                    }
                }.padding(.vertical, 12)
            }
            Section("Layout") {
                Toggle("Align text baselines", isOn: $alignBaselines)
                Slider(value: $spacing, in: 0...32, step: 4) { Text("Stack spacing") }
                LabeledContent("Spacing", value: "\(Int(spacing)) pt")
            }
        }
        .navigationTitle("Stack spacing and alignment")
        .navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
}

#Preview { NavigationStack { StackAlignmentDemo() } }

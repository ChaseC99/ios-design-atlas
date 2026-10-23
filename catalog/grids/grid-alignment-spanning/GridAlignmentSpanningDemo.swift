import SwiftUI

struct GridAlignmentSpanningDemo: View {
    @State private var generousSpacing = true
    private let isCapturing = ProcessInfo.processInfo.arguments.contains("--capture")
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 28) {
                VStack(alignment: .leading, spacing: 10) {
                    Text("A week outside").font(.system(.largeTitle, design: .serif).weight(.semibold))
                    Text("Little moments add up.").foregroundStyle(.secondary)
                }
                Grid(alignment: .leading, horizontalSpacing: generousSpacing ? 20 : 8, verticalSpacing: generousSpacing ? 24 : 12) {
                    GridRow {
                        Text("DAY").gridColumnAlignment(.leading)
                        Text("DISTANCE").gridColumnAlignment(.trailing)
                        Text("TIME").gridColumnAlignment(.trailing)
                    }.font(.caption.weight(.semibold)).foregroundStyle(.secondary)
                    Divider().gridCellColumns(3).gridCellUnsizedAxes(.horizontal)
                    activity("Monday", distance: "3.2 km", duration: "42 min", symbol: "sun.max")
                    activity("Wednesday", distance: "5.6 km", duration: "68 min", symbol: "cloud.sun")
                    activity("Friday", distance: "2.8 km", duration: "35 min", symbol: "sun.horizon")
                    Divider().gridCellColumns(3).gridCellUnsizedAxes(.horizontal)
                    GridRow {
                        Text("This week").fontWeight(.semibold)
                        Text("11.6 km").fontWeight(.semibold)
                        Text("145 min").fontWeight(.semibold)
                    }
                    Label("A little further than last week.", systemImage: "arrow.up.right")
                        .font(.subheadline).foregroundStyle(.teal).padding(.top, 6).gridCellColumns(3)
                }
                .padding(22).background(Color(uiColor: .secondarySystemGroupedBackground), in: .rect(cornerRadius: 24))
                if !isCapturing { Toggle("Generous spacing", isOn: $generousSpacing) }
            }.padding(22)
        }
        .background(Color(uiColor: .systemGroupedBackground))
        .navigationTitle("Activity")
        .navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
    private func activity(_ day: String, distance: String, duration: String, symbol: String) -> some View {
        GridRow {
            VStack(alignment: .leading, spacing: 6) { Image(systemName: symbol).foregroundStyle(.orange); Text(day) }
            Text(distance).monospacedDigit()
            Text(duration).monospacedDigit().foregroundStyle(.secondary)
        }.font(.subheadline)
    }
}

#Preview { NavigationStack { GridAlignmentSpanningDemo() } }

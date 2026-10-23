import SwiftUI
import Charts

struct ChartSelectionDemo: View {
    @State private var selectedHour: Int? = 14
    private let readings = [18.0, 19.0, 21.5, 23.0, 24.5, 23.2, 21.0]
    private var selectedIndex: Int? {
        guard let hour = selectedHour else { return nil }
        return readings.indices.min(by: { abs((8 + $0 * 2) - hour) < abs((8 + $1 * 2) - hour) })
    }
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Text("A day by the coast").font(.title2.bold())
                HStack(alignment: .firstTextBaseline) {
                    Text(selectedIndex.map { String(format: "%.1f°", readings[$0]) } ?? "—")
                        .font(.system(size: 52, weight: .semibold, design: .rounded)).monospacedDigit()
                    Text(selectedIndex.map { "at \(8 + $0 * 2):00" } ?? "Select a reading").foregroundStyle(.secondary)
                }
                Chart {
                    ForEach(readings.indices, id: \.self) { index in
                        LineMark(x: .value("Hour", 8 + index * 2), y: .value("Celsius", readings[index]))
                            .interpolationMethod(.monotone).foregroundStyle(.orange)
                    }
                    if let index = selectedIndex {
                        RuleMark(x: .value("Hour", 8 + index * 2))
                            .foregroundStyle(.secondary.opacity(0.5)).lineStyle(StrokeStyle(dash: [4, 4]))
                        PointMark(x: .value("Hour", 8 + index * 2), y: .value("Celsius", readings[index]))
                            .foregroundStyle(.orange).symbolSize(110)
                    }
                }
                .chartXSelection(value: $selectedHour)
                .chartYScale(domain: 15...28)
                .chartXAxis { AxisMarks(values: [8, 12, 16, 20]) { value in
                    AxisGridLine(); AxisTick()
                    AxisValueLabel { if let hour = value.as(Int.self) { Text("\(hour):00") } }
                } }
                .chartYAxisLabel("°C").frame(height: 280)
                .accessibilityLabel("Temperature through the day")
                HStack {
                    Button("Previous", systemImage: "chevron.left") { move(-1) }.labelStyle(.iconOnly)
                    Spacer()
                    Text("Drag across the chart").font(.subheadline).foregroundStyle(.secondary)
                    Spacer()
                    Button("Next", systemImage: "chevron.right") { move(1) }.labelStyle(.iconOnly)
                }
                .buttonStyle(.bordered)
            }.padding(24)
        }
        .navigationTitle("Temperature").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
    private func move(_ offset: Int) {
        let index = min(max((selectedIndex ?? 0) + offset, 0), readings.count - 1)
        selectedHour = 8 + index * 2
    }
}

#Preview { NavigationStack { ChartSelectionDemo() } }

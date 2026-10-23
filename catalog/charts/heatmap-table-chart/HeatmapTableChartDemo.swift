import SwiftUI
import Charts

struct HeatmapTableChartDemo: View {
    private struct Reading: Identifiable {
        let id: Int
        let day: String
        let period: String
        let count: Int
        var label: String { "\(day) · \(period)" }
    }
    @State private var mode = "Heatmap"
    @State private var sortOrder = [KeyPathComparator(\Reading.count, order: .reverse)]
    @Environment(\.horizontalSizeClass) private var sizeClass
    private let days = ["Mon", "Tue", "Wed", "Thu", "Fri"]
    private let periods = ["Morning", "Midday", "Evening"]
    private var readings: [Reading] {
        days.indices.flatMap { day in periods.indices.map { period in
            Reading(id: day * 3 + period, day: days[day], period: periods[period], count: [8, 14, 6, 11, 18, 9, 7, 12, 5, 13, 20, 10, 16, 24, 12][day * 3 + period])
        } }
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            VStack(alignment: .leading, spacing: 8) {
                Text("When the garden wakes").font(.title2.bold())
                Text("Fictional visitor counts by time of day").foregroundStyle(.secondary)
            }
            Picker("Display", selection: $mode) { Text("Heatmap").tag("Heatmap"); Text("Data").tag("Data") }.pickerStyle(.segmented)
            if mode == "Heatmap" {
                Chart(readings) { reading in
                    RectangleMark(x: .value("Day", reading.day), y: .value("Period", reading.period))
                        .foregroundStyle(by: .value("Visitors", reading.count))
                        .annotation(position: .overlay) { Text("\(reading.count)").font(.subheadline.weight(.semibold)).foregroundStyle(reading.count > 14 ? .white : .primary) }
                        .accessibilityLabel(reading.label).accessibilityValue("\(reading.count) visitors")
                }
                .chartXScale(domain: days)
                .chartYScale(domain: Array(periods.reversed()))
                .chartForegroundStyleScale(range: Gradient(colors: [.mint.opacity(0.18), .teal]))
                .chartLegend(position: .bottom, alignment: .leading)
                .frame(height: 280)
                Text("Friday at midday is busiest: 24 visitors.").font(.subheadline).foregroundStyle(.secondary)
                Spacer()
            } else {
                if sizeClass == .compact {
                    Button("Sort by visits", systemImage: "arrow.up.arrow.down") {
                        sortOrder = [KeyPathComparator(\Reading.count, order: sortOrder.first?.order == .reverse ? .forward : .reverse)]
                    }
                }
                Table(readings.sorted(using: sortOrder), sortOrder: $sortOrder) {
                    TableColumn("Time", value: \.label) { reading in
                        VStack(alignment: .leading) {
                            Text(reading.label)
                            if sizeClass == .compact { Text("\(reading.count) visitors").foregroundStyle(.secondary).font(.caption) }
                        }
                    }
                    TableColumn("Visitors", value: \.count) { reading in Text("\(reading.count)").monospacedDigit() }
                }
            }
        }.padding(24)
        .navigationTitle("Garden visits").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
}

#Preview { NavigationStack { HeatmapTableChartDemo() } }

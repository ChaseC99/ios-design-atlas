import SwiftUI
import Charts

struct ScrollingTimeSeriesDemo: View {
    @State private var days = 7
    @State private var position = Date(timeIntervalSince1970: 1772323200 + 28 * 86400)
    private let start = Date(timeIntervalSince1970: 1772323200)
    private var end: Date { start.addingTimeInterval(59 * 86400) }
    private var average: Int {
        var total = 0
        for day in 0..<60 { total += 3200 + (day * 1137) % 6200 }
        return total / 60
    }
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Text("Every step adds up").font(.title2.bold())
                HStack(alignment: .firstTextBaseline) {
                    Text(average, format: .number).font(.largeTitle.bold()).monospacedDigit()
                    Text("average daily steps").foregroundStyle(.secondary)
                }
                Picker("Visible days", selection: $days) { Text("Week").tag(7); Text("Two weeks").tag(14) }.pickerStyle(.segmented)
                Chart(0..<60, id: \.self) { day in
                    BarMark(x: .value("Date", start.addingTimeInterval(Double(day) * 86400), unit: .day),
                            y: .value("Steps", 3200 + (day * 1137) % 6200))
                        .cornerRadius(3).foregroundStyle(.mint.gradient)
                }
                .chartScrollableAxes(.horizontal)
                .chartXVisibleDomain(length: Double(days) * 86400)
                .chartScrollPosition(x: $position)
                .chartYScale(domain: 0...10000)
                .chartXAxis { AxisMarks(values: .stride(by: .day, count: days == 7 ? 1 : 2)) { _ in
                    AxisValueLabel(format: .dateTime.day().month(.abbreviated), centered: true)
                } }
                .chartYAxis { AxisMarks(position: .leading, values: [0, 5000, 10000]) }
                .frame(height: 300)
                .accessibilityLabel("Daily steps, March and April 2026")
                HStack {
                    Button("Earlier", systemImage: "chevron.left") { move(-days) }
                    Spacer()
                    Button("Later", systemImage: "chevron.right") { move(days) }
                }.buttonStyle(.bordered)
                Text("\(position.formatted(Date.FormatStyle(date: .abbreviated, time: .omitted, timeZone: TimeZone(secondsFromGMT: 0)!))) · \(days)-day window")
                    .font(.subheadline).foregroundStyle(.secondary)
            }.padding(24)
        }
        .environment(\.timeZone, TimeZone(secondsFromGMT: 0)!)
        .navigationTitle("Daily steps").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
    private func move(_ offset: Int) {
        position = min(max(position.addingTimeInterval(Double(offset) * 86400), start), end.addingTimeInterval(Double(1 - days) * 86400))
    }
}

#Preview { NavigationStack { ScrollingTimeSeriesDemo() } }

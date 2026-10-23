import SwiftUI
import Charts

struct ChartMarkTypesDemo: View {
    @State private var style = "Bars"
    private let values = [32, 48, 41, 64, 52, 77, 58]
    private let days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    private let isCapturing = ProcessInfo.processInfo.arguments.contains("--capture")
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Time outside").font(.title2.bold())
                    Text("6 hr 12 min").font(.largeTitle.bold()).monospacedDigit()
                    Text("A little fresh air, every day.").foregroundStyle(.secondary)
                }
                if !isCapturing {
                    Picker("Chart style", selection: $style) {
                        ForEach(["Bars", "Line", "Area", "Points"], id: \.self) { Text($0) }
                    }.pickerStyle(.segmented)
                }
                Chart {
                    ForEach(values.indices, id: \.self) { index in
                        switch style {
                        case "Line":
                            LineMark(x: .value("Day", days[index]), y: .value("Minutes", values[index]))
                                .symbol(.circle).interpolationMethod(.monotone)
                        case "Area":
                            AreaMark(x: .value("Day", days[index]), y: .value("Minutes", values[index]))
                                .foregroundStyle(.teal.opacity(0.18))
                            LineMark(x: .value("Day", days[index]), y: .value("Minutes", values[index]))
                        case "Points":
                            PointMark(x: .value("Day", days[index]), y: .value("Minutes", values[index])).symbolSize(90)
                        default:
                            BarMark(x: .value("Day", days[index]), y: .value("Minutes", values[index])).cornerRadius(5)
                        }
                    }
                    RuleMark(y: .value("Goal", 60))
                        .foregroundStyle(.secondary).lineStyle(StrokeStyle(lineWidth: 1, dash: [4, 4]))
                        .annotation(position: .top, alignment: .trailing) { Text("Daily goal").font(.caption).foregroundStyle(.secondary) }
                }
                .foregroundStyle(.teal)
                .chartYScale(domain: 0...90)
                .chartYAxisLabel("Minutes")
                .chartYAxis { AxisMarks(position: .leading, values: [0, 30, 60, 90]) }
                .frame(height: 280)
                .accessibilityLabel("Time outside this week")
                .accessibilityValue("372 minutes total. Saturday was highest at 77 minutes.")
                Divider()
                HStack {
                    Label("Best day", systemImage: "sun.max").foregroundStyle(.secondary)
                    Spacer()
                    Text("Saturday · 77 min").fontWeight(.medium)
                }
            }.padding(24)
        }
        .navigationTitle("Weekly rhythm").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
}

#Preview { NavigationStack { ChartMarkTypesDemo() } }

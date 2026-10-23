import SwiftUI
import Charts

struct MultiSeriesChartDemo: View {
    @State private var groupedBars = false
    private let morning = [24, 32, 28, 40, 36, 44, 39]
    private let evening = [19, 24, 31, 33, 29, 39, 42]
    private let days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    private let isCapturing = ProcessInfo.processInfo.arguments.contains("--capture")
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Text("Two ways to unwind").font(.title2.bold())
                Text("Minutes walked, morning and evening").foregroundStyle(.secondary)
                if !isCapturing { Toggle("Grouped bars", isOn: $groupedBars) }
                Chart {
                    ForEach(["Morning", "Evening"], id: \.self) { series in
                        ForEach(days.indices, id: \.self) { index in
                            if groupedBars {
                                BarMark(x: .value("Day", days[index]), y: .value("Minutes", value(series, index)))
                                    .foregroundStyle(by: .value("Time", series))
                                    .position(by: .value("Time", series)).cornerRadius(3)
                            } else {
                                LineMark(x: .value("Day", days[index]), y: .value("Minutes", value(series, index)))
                                    .foregroundStyle(by: .value("Time", series))
                                    .symbol(by: .value("Time", series)).interpolationMethod(.monotone)
                            }
                        }
                    }
                }
                .chartForegroundStyleScale(["Morning": Color.orange, "Evening": Color.indigo])
                .chartSymbolScale(["Morning": BasicChartSymbolShape.circle, "Evening": BasicChartSymbolShape.diamond])
                .chartYScale(domain: 0...50)
                .chartLegend(position: .bottom, alignment: .leading, spacing: 16)
                .frame(height: 320)
                .accessibilityLabel("Walking time by morning and evening")
                Divider()
                LabeledContent("Morning total", value: "243 min")
                LabeledContent("Evening total", value: "217 min")
            }.padding(24)
        }
        .navigationTitle("Walking rhythms").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
    private func value(_ series: String, _ index: Int) -> Int { series == "Morning" ? morning[index] : evening[index] }
}

#Preview { NavigationStack { MultiSeriesChartDemo() } }

import SwiftUI
import Charts

struct ChartDataEdgeCasesDemo: View {
    @State private var scenario = "Missing"
    private let scenarios = ["Missing", "Sparse", "Empty", "Negative", "Tiny", "Large"]
    private var values: [Double?] {
        switch scenario {
        case "Sparse": return [nil, nil, 6, nil, nil, nil, nil]
        case "Empty": return Array(repeating: nil, count: 7)
        case "Negative": return [4, -2, 3, -5, 2, 6, -1]
        case "Tiny": return [0.0002, 0.0004, 0.0003, 0.0008, 0.0006, 0.0009, 0.0007]
        case "Large": return [1_200_000, 1_800_000, 1_400_000, 2_400_000, 2_000_000, 2_800_000, 2_600_000]
        default: return [4, 6, nil, nil, 8, 7, 9]
        }
    }
    private var domain: ClosedRange<Double> {
        let data = values.compactMap { $0 }; let low = min(data.min() ?? 0, 0); let high = max(data.max() ?? 1, 0)
        let padding = max((high - low) * 0.15, 0.00001)
        return (low < 0 ? low - padding : 0)...(high + padding)
    }
    private func segment(_ index: Int) -> Int { values.prefix(index).filter { $0 == nil }.count }
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Text("Keep the gaps honest").font(.title2.bold())
                Text("A missing reading is not a zero.").foregroundStyle(.secondary)
                Picker("Dataset", selection: $scenario) { ForEach(scenarios, id: \.self) { Text($0) } }.pickerStyle(.menu)
                if values.allSatisfy({ $0 == nil }) {
                    ContentUnavailableView("No readings", systemImage: "chart.xyaxis.line", description: Text("Readings appear here when they are available.")).frame(height: 290)
                } else {
                    Chart {
                        ForEach(values.indices, id: \.self) { day in
                            if let value = values[day] {
                                LineMark(x: .value("Day", day + 1), y: .value("Reading", value), series: .value("Segment", segment(day)))
                                    .foregroundStyle(.teal)
                                PointMark(x: .value("Day", day + 1), y: .value("Reading", value)).foregroundStyle(.teal).symbolSize(60)
                            }
                        }
                        if scenario == "Negative" { RuleMark(y: .value("Zero", 0)).foregroundStyle(.secondary) }
                    }
                    .chartXScale(domain: 1...7).chartYScale(domain: domain)
                    .chartYAxis { AxisMarks(format: FloatingPointFormatStyle<Double>.number.notation(.compactName).precision(.significantDigits(1...3)), position: .leading) }
                    .chartXAxis { AxisMarks(values: [1, 2, 3, 4, 5, 6, 7]) }
                    .frame(height: 290)
                    .accessibilityLabel("\(scenario) sample readings")
                }
                VStack(spacing: 12) {
                    ForEach(values.indices, id: \.self) { day in
                        LabeledContent("Day \(day + 1)") {
                            if let value = values[day] { Text(value, format: .number.precision(.fractionLength(0...4))).monospacedDigit() }
                            else { Text("No reading").foregroundStyle(.secondary) }
                        }.font(.subheadline)
                    }
                }
            }.padding(24)
        }
        .navigationTitle("Imperfect data").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
}

#Preview { NavigationStack { ChartDataEdgeCasesDemo() } }

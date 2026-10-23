import SwiftUI
import Charts

struct TimelineChartDemo: View {
    private struct Activity: Identifiable {
        let id: String
        let start: Double
        let end: Double
        let symbol: String
    }
    @State private var selected = "Coastal walk"
    private let activities = [Activity(id: "Coffee", start: 9, end: 9.75, symbol: "cup.and.saucer"), Activity(id: "Coastal walk", start: 9.5, end: 11.5, symbol: "figure.walk"), Activity(id: "Read", start: 11.75, end: 12.5, symbol: "book"), Activity(id: "Lunch", start: 12.25, end: 13.25, symbol: "fork.knife")]
    private var selection: Activity { activities.first { $0.id == selected } ?? activities[0] }
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Text("An unhurried Saturday").font(.title2.bold())
                Text("A little room between things.").foregroundStyle(.secondary)
                Chart {
                    ForEach(activities) { activity in
                        BarMark(xStart: .value("Start", activity.start), xEnd: .value("End", activity.end), y: .value("Activity", activity.id), height: 24)
                            .foregroundStyle(activity.id == selected ? Color.teal : Color.teal.opacity(0.25)).cornerRadius(6)
                            .accessibilityLabel(activity.id)
                            .accessibilityValue("\(time(activity.start)) to \(time(activity.end))")
                    }
                    RuleMark(x: .value("Selected start", selection.start)).foregroundStyle(.secondary).lineStyle(StrokeStyle(dash: [3, 3]))
                }
                .chartXScale(domain: 8.5...14)
                .chartYScale(domain: activities.map(\.id))
                .chartXAxis { AxisMarks(values: [9, 10, 11, 12, 13, 14]) { value in
                    AxisGridLine(); AxisTick()
                    AxisValueLabel { if let hour = value.as(Int.self) { Text("\(hour):00") } }
                } }
                .frame(height: 280)
                VStack(spacing: 14) {
                    ForEach(activities) { activity in
                        Button { selected = activity.id } label: {
                            HStack {
                                Image(systemName: activity.symbol).frame(width: 24).foregroundStyle(.teal)
                                Text(activity.id).foregroundStyle(.primary)
                                Spacer()
                                Text("\(Int((activity.end - activity.start) * 60)) min").font(.subheadline).foregroundStyle(.secondary)
                                Image(systemName: selected == activity.id ? "checkmark.circle.fill" : "circle").foregroundStyle(.teal)
                            }.padding(.vertical, 6).contentShape(Rectangle())
                        }.buttonStyle(.plain).accessibilityAddTraits(selected == activity.id ? .isSelected : [])
                    }
                }
            }.padding(24)
        }
        .navigationTitle("A day, at a glance").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
    private func time(_ hour: Double) -> String { String(format: "%02d:%02d", Int(hour), Int((hour - floor(hour)) * 60)) }
}

#Preview { NavigationStack { TimelineChartDemo() } }

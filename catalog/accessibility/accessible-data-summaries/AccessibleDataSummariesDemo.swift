import SwiftUI
import Charts

struct AccessibleDataSummariesDemo: View {
    private let minutes: [(String, Int)] = [("Mon", 25), ("Tue", 40), ("Wed", 30), ("Thu", 55), ("Fri", 35), ("Sat", 70), ("Sun", 50)]
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Text("A week outside").font(.largeTitle.bold()).accessibilityAddTraits(.isHeader)
                HStack(alignment: .firstTextBaseline, spacing: 10) {
                    Text("305").font(.system(.largeTitle, design: .rounded).bold())
                    Text("minutes outdoors").foregroundStyle(.secondary)
                }.accessibilityElement(children: .ignore).accessibilityLabel("Time outdoors this week").accessibilityValue("305 minutes")
                Chart(minutes, id: \.0) { day, value in
                    BarMark(x: .value("Day", day), y: .value("Minutes", value))
                        .foregroundStyle(.teal.gradient).cornerRadius(6)
                        .accessibilityLabel(day).accessibilityValue("\(value) minutes outdoors")
                }.frame(height: 230).accessibilityLabel("Daily time outdoors")
                Text("Saturday was your most active day, with 70 minutes outside. Thursday was next, with 55 minutes.")
                    .font(.subheadline).foregroundStyle(.secondary)
                Divider()
                ZStack {
                    RoundedRectangle(cornerRadius: 22).fill(.indigo.opacity(0.1))
                    Image(systemName: "mountain.2.fill").font(.system(size: 75)).foregroundStyle(.indigo)
                }.frame(height: 170)
                    .accessibilityElement(children: .ignore)
                    .accessibilityLabel("Illustration of two mountain peaks")
                Text("Make a little room for the view.").font(.caption).foregroundStyle(.secondary)
            }.padding(24)
        }
        .navigationTitle("Your week").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
}

#Preview { NavigationStack { AccessibleDataSummariesDemo() } }

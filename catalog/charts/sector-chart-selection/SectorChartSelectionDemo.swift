import SwiftUI
import Charts

struct SectorChartSelectionDemo: View {
    @State private var selection: Double? = 50
    private let items: [(name: String, minutes: Double)] = [("Walking", 160), ("Reading", 95), ("Making", 65), ("Rest", 40)]
    private let colors: [Color] = [.teal, .indigo, .orange, .pink]
    private var selectedIndex: Int? {
        guard let selection else { return nil }
        var total = 0.0
        for index in items.indices { total += items[index].minutes; if selection < total { return index } }
        return nil
    }
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Text("Room for good things").font(.title2.bold())
                Text("360 minutes, well spent.").foregroundStyle(.secondary)
                Chart(items.indices, id: \.self) { index in
                    SectorMark(angle: .value("Minutes", items[index].minutes), innerRadius: .ratio(0.68), angularInset: 3)
                        .cornerRadius(5)
                        .foregroundStyle(by: .value("Activity", items[index].name))
                        .opacity(selectedIndex == nil || selectedIndex == index ? 1 : 0.4)
                        .accessibilityLabel(items[index].name)
                        .accessibilityValue("\(Int(items[index].minutes)) minutes")
                }
                .chartForegroundStyleScale(domain: items.map(\.name), range: colors)
                .chartLegend(.hidden)
                .chartAngleSelection(value: $selection)
                .frame(height: 300)
                .overlay {
                    VStack(spacing: 4) {
                        Text(selectedIndex.map { "\(Int(items[$0].minutes))" } ?? "360").font(.largeTitle.bold()).monospacedDigit()
                        Text(selectedIndex.map { items[$0].name } ?? "Total minutes").font(.subheadline).foregroundStyle(.secondary)
                    }.allowsHitTesting(false)
                }
                VStack(spacing: 16) {
                    ForEach(items.indices, id: \.self) { index in
                        Button {
                            selection = items.prefix(index).reduce(0) { $0 + $1.minutes } + items[index].minutes / 2
                        } label: {
                            HStack {
                                Circle().fill(colors[index]).frame(width: 10, height: 10)
                                Text(items[index].name).foregroundStyle(.primary)
                                Spacer()
                                Text("\(Int(items[index].minutes)) min").foregroundStyle(.secondary).monospacedDigit()
                                Image(systemName: selectedIndex == index ? "checkmark.circle.fill" : "circle").foregroundStyle(colors[index])
                            }.contentShape(Rectangle())
                        }.buttonStyle(.plain).accessibilityAddTraits(selectedIndex == index ? .isSelected : [])
                    }
                }
            }.padding(24)
        }
        .navigationTitle("Your weekend").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
}

#Preview { NavigationStack { SectorChartSelectionDemo() } }

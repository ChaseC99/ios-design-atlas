import SwiftUI
import WidgetKit

struct AtlasReadingEntry: TimelineEntry {
    let date: Date
    let pages: Int
    let goal: Int
}
struct AtlasReadingProvider: TimelineProvider {
    func placeholder(in context: Context) -> AtlasReadingEntry { sample }
    func getSnapshot(in context: Context, completion: @escaping (AtlasReadingEntry) -> Void) { completion(sample) }
    func getTimeline(in context: Context, completion: @escaping (Timeline<AtlasReadingEntry>) -> Void) {
        completion(Timeline(entries: [sample], policy: .never))
    }
    private var sample: AtlasReadingEntry { AtlasReadingEntry(date: .now, pages: 32, goal: 50) }
}
struct AtlasReadingWidgetContent: View {
    @Environment(\.widgetFamily) private var systemFamily
    let entry: AtlasReadingEntry
    private let previewFamily: WidgetFamily?
    private var family: WidgetFamily { previewFamily ?? systemFamily }
    init(entry: AtlasReadingEntry, previewFamily: WidgetFamily? = nil) {
        self.entry = entry
        self.previewFamily = previewFamily
    }
    var body: some View {
        switch family {
        case .accessoryInline:
            Label("\(entry.pages) of \(entry.goal) pages", systemImage: "book.closed")
        case .accessoryCircular:
            Gauge(value: Double(entry.pages), in: 0...Double(entry.goal)) {
                Image(systemName: "book.closed")
            } currentValueLabel: { Text(entry.pages, format: .number) }
            .gaugeStyle(.accessoryCircular)
        case .accessoryRectangular:
            VStack(alignment: .leading) {
                Label("Reading today", systemImage: "book.closed").font(.headline)
                ProgressView(value: Double(entry.pages), total: Double(entry.goal))
                Text("\(entry.pages) of \(entry.goal) pages").font(.caption)
            }
        default:
            VStack(alignment: .leading, spacing: 12) {
                Label("READING TODAY", systemImage: "book.closed.fill")
                    .font(.caption.weight(.semibold)).foregroundStyle(.secondary)
                HStack(alignment: .firstTextBaseline, spacing: 5) {
                    Text(entry.pages, format: .number).font(.system(size: family == .systemSmall ? 40 : 48, weight: .semibold, design: .rounded))
                    Text("/ \(entry.goal) pages").font(.subheadline).foregroundStyle(.secondary).lineLimit(1).minimumScaleFactor(0.8)
                }
                ProgressView(value: Double(entry.pages), total: Double(entry.goal)).tint(.teal)
                if family != .systemSmall {
                    Text("A little time, a different world.").font(.subheadline)
                }
                if family == .systemLarge {
                    Divider().padding(.vertical, 8)
                    Label("The Long Way Home", systemImage: "bookmark").font(.headline)
                    Text("Chapter 4 · A place by the water").foregroundStyle(.secondary)
                    Spacer(minLength: 0)
                }
            }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
    }
}
struct AtlasReadingWidget: Widget {
    let kind = "AtlasReadingWidget"
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: AtlasReadingProvider()) { entry in
            AtlasReadingWidgetContent(entry: entry).containerBackground(.background, for: .widget)
        }
        .configurationDisplayName("Reading progress")
        .description("A local sample in Home Screen and Lock Screen families.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge, .accessoryInline, .accessoryCircular, .accessoryRectangular])
    }
}
struct WidgetFamiliesDemo: View {
    @State private var family: WidgetFamily = .systemSmall
    private let families: [WidgetFamily] = [.systemSmall, .systemMedium, .systemLarge, .accessoryCircular, .accessoryRectangular, .accessoryInline]
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Picker("Family", selection: $family) {
                    ForEach(families, id: \.self) { Text(String(describing: $0)).tag($0) }
                }
                AtlasReadingWidgetContent(entry: AtlasReadingEntry(date: .now, pages: 32, goal: 50), previewFamily: family)
                    .padding(24).frame(maxWidth: 380, minHeight: family == .systemLarge ? 300 : 160)
                    .background(.teal.opacity(0.08), in: RoundedRectangle(cornerRadius: 28))
                Text("Content preview").font(.headline)
                Text("Add Reading progress from the Atlas widget collection to the Home Screen or Lock Screen to inspect the actual system frame, margins, and rendering mode.").foregroundStyle(.secondary)
            }.padding(24)
        }.navigationTitle("Widget families")
    }
}
#Preview { NavigationStack { WidgetFamiliesDemo() } }

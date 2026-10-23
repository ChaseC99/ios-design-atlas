import SwiftUI
import WidgetKit
import AppIntents

#if ATLAS_WIDGET_EXTENSION
// The extension-only flag keeps the intent and its local store out of the app target.
private enum AtlasWidgetWaterStore {
    static let key = "atlas.widget.glasses"
    static var glasses: Int {
        min(8, max(0, UserDefaults.standard.object(forKey: key) as? Int ?? 3))
    }
}
struct AtlasWaterEntry: TimelineEntry { let date: Date; let glasses: Int }
struct AtlasWaterProvider: TimelineProvider {
    func placeholder(in context: Context) -> AtlasWaterEntry { AtlasWaterEntry(date: .now, glasses: 3) }
    func getSnapshot(in context: Context, completion: @escaping (AtlasWaterEntry) -> Void) {
        completion(context.isPreview ? placeholder(in: context) : current)
    }
    func getTimeline(in context: Context, completion: @escaping (Timeline<AtlasWaterEntry>) -> Void) {
        completion(Timeline(entries: [current], policy: .never))
    }
    private var current: AtlasWaterEntry { AtlasWaterEntry(date: .now, glasses: AtlasWidgetWaterStore.glasses) }
}
struct AtlasAddWaterIntent: AppIntent {
    static let title: LocalizedStringResource = "Add a glass"
    static let description = IntentDescription("Increment the local widget sample counter.")
    static let isDiscoverable = false
    @MainActor func perform() async throws -> some IntentResult {
        UserDefaults.standard.set(min(AtlasWidgetWaterStore.glasses + 1, 8), forKey: AtlasWidgetWaterStore.key)
        // The tapped widget reloads automatically; also request other instances of this kind.
        WidgetCenter.shared.reloadTimelines(ofKind: "AtlasWaterWidget")
        return .result()
    }
}
struct AtlasResetWaterIntent: AppIntent {
    static let title: LocalizedStringResource = "Reset sample"
    static let isDiscoverable = false
    @MainActor func perform() async throws -> some IntentResult {
        UserDefaults.standard.set(3, forKey: AtlasWidgetWaterStore.key)
        WidgetCenter.shared.reloadTimelines(ofKind: "AtlasWaterWidget")
        return .result()
    }
}
struct AtlasWaterWidget: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "AtlasWaterWidget", provider: AtlasWaterProvider()) { entry in
            VStack(alignment: .leading, spacing: 10) {
                Label("WATER BREAK", systemImage: "drop.fill").font(.caption.bold()).foregroundStyle(.teal)
                Text("\(entry.glasses) / 8").font(.largeTitle.bold()).invalidatableContent()
                ProgressView(value: Double(entry.glasses), total: 8).tint(.teal)
                if entry.glasses >= 8 {
                    Button(intent: AtlasResetWaterIntent()) { Label("Reset sample", systemImage: "arrow.counterclockwise") }
                        .buttonStyle(.bordered).controlSize(.small)
                } else {
                    Button(intent: AtlasAddWaterIntent()) { Label("Add a glass", systemImage: "plus") }
                        .buttonStyle(.bordered).controlSize(.small)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            .containerBackground(.background, for: .widget)
        }
        .configurationDisplayName("Water break")
        .description("An interactive local sample; no health data is recorded.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}
#else
struct InteractiveWidgetDemo: View {
    @State private var glasses = 3
    var body: some View {
        Form {
            Section("Content preview") {
                Label("Water break", systemImage: "drop.fill").foregroundStyle(.teal)
                Text("\(glasses) of 8 glasses").font(.largeTitle.bold())
                ProgressView(value: Double(glasses), total: 8)
                Button("Add a sample glass") { glasses = min(glasses + 1, 8) }.disabled(glasses == 8)
                Button("Reset preview") { glasses = 3 }
            }
            Section {
                Text("Add Water break to the Home Screen to run the real App Intent. This preview has independent temporary state; the extension owns its local counter.")
                    .foregroundStyle(.secondary)
            }
        }.navigationTitle("Interactive widget")
    }
}
#Preview { NavigationStack { InteractiveWidgetDemo() } }
#endif

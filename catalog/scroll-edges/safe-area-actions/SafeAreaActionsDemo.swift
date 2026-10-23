import SwiftUI

struct SafeAreaActionsDemo: View {
    private let capturing = ProcessInfo.processInfo.arguments.contains("--capture")
    @State private var saved = false
    @State private var showSummary = true
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                if !capturing { Toggle("Add a second inset", isOn: $showSummary) }
                Text("A weekend\nwithout a plan.").font(.system(.largeTitle, design: .serif, weight: .medium))
                Text("SLOW TRAVEL · 3 DAYS").font(.caption.weight(.semibold)).tracking(2).foregroundStyle(.secondary)
                ForEach(["Find a quiet place", "Take the long way", "Leave room for nothing", "Watch the light change", "Keep a small memory"], id: \.self) { title in
                    HStack(alignment: .top, spacing: 16) {
                        Image(systemName: "circle.dotted").foregroundStyle(.orange).font(.title2)
                        VStack(alignment: .leading, spacing: 8) {
                            Text(title).font(.headline)
                            Text("A little space for a different kind of day.").foregroundStyle(.secondary)
                        }
                    }.padding(.vertical, 14)
                }
            }.padding(28)
        }
        .safeAreaInset(edge: .bottom, spacing: 0) {
            if showSummary {
                HStack { Text("Your itinerary"); Spacer(); Text("5 moments").foregroundStyle(.secondary) }
                    .font(.caption).padding(.horizontal, 28).padding(.vertical, 12)
                    .background(.bar)
            }
        }
        .safeAreaInset(edge: .bottom, spacing: 0) {
            Button {
                saved.toggle()
            } label: {
                Label(saved ? "Saved to your collection" : "Save this itinerary", systemImage: saved ? "checkmark" : "bookmark")
                    .frame(maxWidth: .infinity).padding(.vertical, 10)
            }
            .buttonStyle(.borderedProminent).tint(.orange)
            .padding(.horizontal, 24).padding(.vertical, 12).background(.bar)
        }
        .navigationTitle("Weekend guide").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
}
#Preview { NavigationStack { SafeAreaActionsDemo() } }

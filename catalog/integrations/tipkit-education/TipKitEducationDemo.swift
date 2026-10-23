import SwiftUI
import TipKit

@MainActor private enum AtlasTipSession {
    static let configuration = Result { try Tips.configure([.displayFrequency(.immediate)]) }
}
private struct AtlasCollectionTip: Tip {
    var title: Text { Text("Keep a place for later") }
    var message: Text? { Text("Save places to build a collection for your next trip.") }
    var image: Image? { Image(systemName: "bookmark.fill") }
    var actions: [Action] { Action(id: "save", title: "Save this place") }
}
struct TipKitEducationDemo: View {
    private let tip = AtlasCollectionTip()
    @State private var saved = false
    @State private var ready = false
    @State private var configurationError: String?
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Text("Places to return to").font(.largeTitle.bold())
                if ready { TipView(tip) { _ in save() } }
                if let configurationError { Text(configurationError).font(.caption).foregroundStyle(.secondary) }
                VStack(alignment: .leading, spacing: 20) {
                    Image(systemName: "sun.horizon.fill").font(.system(size: 70)).foregroundStyle(.orange)
                        .frame(maxWidth: .infinity, minHeight: 180).background(.orange.opacity(0.07), in: .rect(cornerRadius: 24))
                    Text("Harbor at golden hour").font(.title2.bold())
                    Text("A quiet spot at the edge of town.").foregroundStyle(.secondary)
                    Button(saved ? "Saved to your collection" : "Save place", systemImage: saved ? "checkmark" : "bookmark") { save() }
                        .buttonStyle(.borderedProminent).disabled(saved)
                }
                if saved { Label("1 place in your collection", systemImage: "tray.full").font(.subheadline).foregroundStyle(.secondary) }
            }.padding(24)
        }
        .navigationTitle("TipKit education").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier(ready || configurationError != nil ? "capture-ready" : "tips-loading")
        .task {
            switch AtlasTipSession.configuration {
            case .success: ready = true
            case .failure: configurationError = "TipKit could not initialize its saved state."
            }
        }
    }
    private func save() { saved = true; tip.invalidate(reason: .actionPerformed) }
}

#Preview { NavigationStack { TipKitEducationDemo() } }

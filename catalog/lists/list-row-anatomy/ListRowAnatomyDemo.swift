import SwiftUI

struct ListRowAnatomyDemo: View {
    @State private var notifications = true
    @State private var hideSeparators = false
    @State private var roomy = true
    private let isCapturing = ProcessInfo.processInfo.arguments.contains("--capture")
    var body: some View {
        List {
            Section {
                Label("Simple label", systemImage: "bookmark")
                LabeledContent("Items", value: "24 saved")
                Toggle(isOn: $notifications) { Label("Notifications", systemImage: "bell") }
            }
            Section("With supporting text") {
                HStack(alignment: .top, spacing: 14) {
                    Image(systemName: "mountain.2.fill").font(.title2).foregroundStyle(.white)
                        .frame(width: 58, height: 58).background(.teal.gradient, in: .rect(cornerRadius: 14))
                    VStack(alignment: .leading, spacing: 5) {
                        Text("The scenic route").font(.headline)
                        Text("Notes from a weekend spent taking the long way home.").font(.subheadline).foregroundStyle(.secondary)
                        Text("4 MIN READ").font(.caption2.weight(.semibold)).foregroundStyle(.tertiary)
                    }
                }
                NavigationLink {
                    Text("A new perspective").font(.largeTitle).padding().navigationTitle("Journal")
                } label: {
                    HStack(alignment: .top, spacing: 14) {
                        Image(systemName: "sun.horizon.fill").font(.title2).foregroundStyle(.white)
                            .frame(width: 58, height: 58).background(.orange.gradient, in: .rect(cornerRadius: 14))
                        VStack(alignment: .leading, spacing: 5) {
                            Text("A new perspective").font(.headline)
                            Text("A little space to pause, notice, and begin again.").font(.subheadline).foregroundStyle(.secondary)
                        }
                        Spacer(minLength: 0)
                        Text("NEW").font(.caption2.bold()).padding(.horizontal, 7).padding(.vertical, 4)
                            .foregroundStyle(.indigo).background(.indigo.opacity(0.1), in: .capsule)
                    }
                }
            }
            .listRowInsets(EdgeInsets(top: roomy ? 18 : 8, leading: 18, bottom: roomy ? 18 : 8, trailing: 18))
            .listRowSeparator(hideSeparators ? .hidden : .visible)
            Section {
                Label("A tinted row background", systemImage: "paintpalette")
                    .listRowBackground(Color.indigo.opacity(0.08))
            }
            if !isCapturing {
                Section("Row treatment") {
                    Toggle("Roomier insets", isOn: $roomy)
                    Toggle("Hide article separators", isOn: $hideSeparators)
                }
            }
        }
        .listRowSpacing(roomy ? 4 : 0)
        .navigationTitle("Row anatomy")
        .accessibilityIdentifier("capture-ready")
    }
}

#Preview { NavigationStack { ListRowAnatomyDemo() } }

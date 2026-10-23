import SwiftUI

@available(iOS 26.0, *)
struct BackgroundExtensionDemo: View {
    private let capturing = ProcessInfo.processInfo.arguments.contains("--capture")
    @State private var enabled = true
    @State private var selection: String? = "Coast"
    @State private var visibility: NavigationSplitViewVisibility = .all
    @State private var preferred: NavigationSplitViewColumn = .detail
    var body: some View {
        NavigationSplitView(columnVisibility: $visibility, preferredCompactColumn: $preferred) {
            List(["Coast", "Forest", "Desert"], id: \.self, selection: $selection) { place in
                NavigationLink(place, value: place)
            }.navigationTitle("Places")
        } detail: {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    ZStack {
                        LinearGradient(colors: colors, startPoint: .topLeading, endPoint: .bottomTrailing)
                        Circle().fill(.white.opacity(0.22)).frame(width: 240).offset(x: 80, y: -40)
                        Image(systemName: selection == "Forest" ? "tree.fill" : selection == "Desert" ? "sun.max.fill" : "water.waves")
                            .font(.system(size: 110, weight: .ultraLight)).foregroundStyle(.white.opacity(0.8))
                    }.frame(height: 400).backgroundExtensionEffect(isEnabled: enabled)
                    VStack(alignment: .leading, spacing: 16) {
                        Text(selection ?? "Coast").font(.system(.largeTitle, design: .serif))
                        Text("A place to pause.").font(.title3).foregroundStyle(.secondary)
                        if !capturing { Toggle("Extend background", isOn: $enabled) }
                        Text("Follow the light. Leave the schedule behind.").padding(.top, 16)
                    }.padding(.horizontal, 28)
                }
            }
            .navigationTitle(selection ?? "Coast").navigationBarTitleDisplayMode(.inline)
        }
        .accessibilityIdentifier("capture-ready")
    }
    private var colors: [Color] {
        switch selection {
        case "Forest": [.green, .teal, .mint]
        case "Desert": [.red, .orange, .yellow]
        default: [.indigo, .teal, .cyan]
        }
    }
}
#Preview { if #available(iOS 26.0, *) { BackgroundExtensionDemo() } }

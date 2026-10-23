import SwiftUI

struct NavigationPathRestorationDemo: View {
    private enum Route: String, Codable, Hashable { case collection, place }
    @SceneStorage("atlas.navigation-path.saved") private var savedPath = ""
    @State private var path: [Route] = []
    @State private var restored = false
    @State private var message = ""
    private let isCapturing = ProcessInfo.processInfo.arguments.contains("--capture")
    var body: some View {
        NavigationStack(path: $path) {
            List {
                Section {
                    NavigationLink(value: Route.collection) { Label("Northern coast", systemImage: "water.waves") }
                    Button("Open saved place", systemImage: "arrow.up.forward") { path = [.collection, .place] }
                } header: { Text("Collections") }
                if !isCapturing {
                    Section("Restoration") {
                        Text("The path is saved for this scene. Leave and return to restore the destination.").foregroundStyle(.secondary)
                        Button("Clear saved path", role: .destructive) { savedPath = ""; path = []; message = "Saved path cleared" }
                        if !message.isEmpty { Text(message).foregroundStyle(.secondary) }
                    }
                }
            }
            .navigationTitle("Explore")
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .collection:
                    List { NavigationLink(value: Route.place) { Label("Point Reyes", systemImage: "mappin.and.ellipse") } }
                        .navigationTitle("Northern coast")
                case .place:
                    VStack(spacing: 20) {
                        Image(systemName: "sun.horizon.fill").font(.system(size: 72)).foregroundStyle(.orange)
                        Text("Point Reyes").font(.largeTitle.bold())
                        Text("A little further from the everyday.").foregroundStyle(.secondary)
                        Button("Back to Explore") { path.removeAll() }.buttonStyle(.bordered)
                    }.frame(maxWidth: .infinity, maxHeight: .infinity).padding()
                        .navigationTitle("Saved place").navigationBarTitleDisplayMode(.inline)
                }
            }
        }
        .task {
            guard !restored else { return }
            restored = true
            if !isCapturing, let data = savedPath.data(using: .utf8), let routes = try? JSONDecoder().decode([Route].self, from: data) { path = routes }
        }
        .onChange(of: path) { _, routes in
            guard !isCapturing, let data = try? JSONEncoder().encode(routes), let json = String(data: data, encoding: .utf8) else { return }
            savedPath = json
        }
        .accessibilityIdentifier("capture-ready")
    }
}

#Preview { NavigationPathRestorationDemo() }

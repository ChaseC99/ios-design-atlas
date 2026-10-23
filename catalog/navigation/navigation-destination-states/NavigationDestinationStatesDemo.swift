import SwiftUI

struct NavigationDestinationStatesDemo: View {
    @State private var path: [Bool] = ProcessInfo.processInfo.arguments.contains("--capture") ? [true] : []
    var body: some View {
        NavigationStack(path: $path) {
            List {
                NavigationLink("Available collection", value: false)
                NavigationLink("Unavailable collection", value: true)
            }
            .navigationTitle("Collections")
            .navigationDestination(for: Bool.self) { unavailable in
                DestinationStateContent(unavailable: unavailable)
            }
        }
        .accessibilityIdentifier("capture-ready")
    }
}

private struct DestinationStateContent: View {
    let unavailable: Bool
    @State private var loading = true
    @State private var retry = 0
    @State private var recovered = false
    var body: some View {
        Group {
            if loading {
                ProgressView("Loading collection…")
            } else if unavailable && !recovered {
                ContentUnavailableView {
                    Label("Collection unavailable", systemImage: "wifi.slash")
                } description: {
                    Text("We couldn’t load this collection. Please try again.")
                } actions: {
                    Button("Try Again") { recovered = true; retry += 1 }.buttonStyle(.borderedProminent)
                }
            } else {
                ContentUnavailableView("All caught up", systemImage: "checkmark.circle", description: Text("There are no unread notes in this collection."))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationTitle("Reading list")
        .navigationBarTitleDisplayMode(.inline)
        .task(id: retry) {
            loading = true
            do { try await Task.sleep(for: .seconds(1)) } catch { return }
            loading = false
        }
    }
}

#Preview { NavigationDestinationStatesDemo() }

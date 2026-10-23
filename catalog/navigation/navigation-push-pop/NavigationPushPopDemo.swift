import SwiftUI

struct NavigationPushPopDemo: View {
    @State private var path: [String] = ProcessInfo.processInfo.arguments.contains("--capture") ? ["Coastal walks"] : []
    var body: some View {
        NavigationStack(path: $path) {
            List {
                Section {
                    ForEach(["Coastal walks", "City weekends", "Mountain escapes"], id: \.self) { collection in
                        NavigationLink(value: collection) {
                            Label(collection, systemImage: collection == "Coastal walks" ? "water.waves" : collection == "City weekends" ? "building.2" : "mountain.2")
                                .padding(.vertical, 8)
                        }
                    }
                } header: { Text("Your collections") }
            }
            .navigationTitle("Journeys")
            .navigationDestination(for: String.self) { collection in
                PushPopDestination(title: collection)
            }
        }
        .accessibilityIdentifier("capture-ready")
    }
}

private struct PushPopDestination: View {
    @Environment(\.dismiss) private var dismiss
    let title: String
    var body: some View {
        List {
            Section {
                Label("A place to slow down", systemImage: "sun.horizon")
                Label("Saved for the weekend", systemImage: "bookmark")
            }
            Section {
                NavigationLink("Open itinerary") {
                    ContentUnavailableView("Your itinerary", systemImage: "map", description: Text("A deeper destination in the same stack."))
                        .navigationTitle("Itinerary")
                        .navigationBarTitleDisplayMode(.inline)
                }
                Button("Return to Journeys") { dismiss() }
            }
            if !ProcessInfo.processInfo.arguments.contains("--capture") {
              Section {
                Text("Drag from the leading edge to go back. Reverse direction before releasing to cancel the gesture.")
                    .foregroundStyle(.secondary)
              }
            }
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview { NavigationPushPopDemo() }

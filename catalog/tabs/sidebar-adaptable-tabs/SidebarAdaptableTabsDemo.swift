import SwiftUI

struct SidebarAdaptableTabsDemo: View {
    @State private var selected = "library"
    @AppStorage("atlas.sidebar-tabs.customization") private var customization = TabViewCustomization()
    private let isCapturing = ProcessInfo.processInfo.arguments.contains("--capture")
    var body: some View {
        TabView(selection: $selected) {
            Tab("Library", systemImage: "books.vertical", value: "library") { destination("Library", symbol: "books.vertical") }
                .customizationID("library")
            Tab("Favorites", systemImage: "star", value: "favorites") { destination("Favorites", symbol: "star") }
                .customizationID("favorites")
            TabSection("Collections") {
                Tab("Travel", systemImage: "map", value: "travel") { destination("Travel", symbol: "map") }.customizationID("travel")
                Tab("Ideas", systemImage: "lightbulb", value: "ideas") { destination("Ideas", symbol: "lightbulb") }.customizationID("ideas")
                Tab("Recipes", systemImage: "fork.knife", value: "recipes") { destination("Recipes", symbol: "fork.knife") }.customizationID("recipes")
            }.customizationID("collections")
        }
        .tabViewStyle(.sidebarAdaptable)
        .tabViewCustomization(isCapturing ? .constant(TabViewCustomization()) : $customization)
        .tabViewSidebarHeader {
            Label("ATLAS LIBRARY", systemImage: "square.stack.3d.up").font(.caption.weight(.bold)).padding(.vertical)
        }
        .accessibilityIdentifier("capture-ready")
    }
    private func destination(_ title: String, symbol: String) -> some View {
        NavigationStack {
            List {
                Section {
                    Label(title, systemImage: symbol).font(.largeTitle).padding(.vertical, 20)
                }
                Section("Recently added") {
                    ForEach(["A little inspiration", "Places worth keeping", "Notes for another day"], id: \.self) { item in
                        NavigationLink(item) { Text(item).font(.title).padding().navigationTitle(item) }
                    }
                }
            }.navigationTitle(title)
        }
    }
}

#Preview { SidebarAdaptableTabsDemo() }

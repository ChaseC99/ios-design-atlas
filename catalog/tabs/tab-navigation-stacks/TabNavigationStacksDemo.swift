import SwiftUI

struct TabNavigationStacksDemo: View {
    @State private var selection = 0
    @State private var libraryPath: [String] = []
    @State private var favoritesPath: [String] = []
    private var tabSelection: Binding<Int> {
        Binding(get: { selection }, set: { value in
            if value == selection {
                if value == 0 { libraryPath.removeAll() } else { favoritesPath.removeAll() }
            }
            selection = value
        })
    }
    var body: some View {
        TabView(selection: tabSelection) {
            Tab("Library", systemImage: "books.vertical", value: 0) {
                NavigationStack(path: $libraryPath) {
                    collection(title: "Library", names: ["Small adventures", "Places to return to", "A slower weekend"])
                        .navigationDestination(for: String.self) { title in destination(title: title, path: $libraryPath) }
                }
            }
            Tab("Favorites", systemImage: "star", value: 1) {
                NavigationStack(path: $favoritesPath) {
                    collection(title: "Favorites", names: ["Quiet mornings", "By the water"])
                        .navigationDestination(for: String.self) { title in destination(title: title, path: $favoritesPath) }
                }
            }
        }
        .accessibilityIdentifier("capture-ready")
    }
    private func collection(title: String, names: [String]) -> some View {
        List(names, id: \.self) { name in
            NavigationLink(value: name) {
                Label(name, systemImage: "book.closed").padding(.vertical, 12)
            }
        }.navigationTitle(title)
    }
    private func destination(title: String, path: Binding<[String]>) -> some View {
        List {
            Section {
                Text(title).font(.title2.weight(.semibold)).padding(.vertical)
                Text("Switch tabs and come back. This destination stays in its own stack.").foregroundStyle(.secondary)
            }
            NavigationLink("Open another page", value: "A page inside \(title)")
            Button("Return to this tab’s root") { path.wrappedValue.removeAll() }
        }.navigationTitle(title).navigationBarTitleDisplayMode(.inline)
    }
}

#Preview { TabNavigationStacksDemo() }

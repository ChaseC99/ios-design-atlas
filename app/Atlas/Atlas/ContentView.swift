import SwiftUI

struct ContentView: View {
    @State private var query = ""
    @State private var path: [String] = []

    private var requestedEntry: AtlasEntry? {
        let args = ProcessInfo.processInfo.arguments
        guard let index = args.firstIndex(of: "--entry"), args.indices.contains(index + 1) else { return nil }
        return AtlasCatalog.entries.first { $0.id == args[index + 1] }
    }

    private var filtered: [AtlasEntry] {
        guard !query.isEmpty else { return AtlasCatalog.entries }
        return AtlasCatalog.entries.filter {
            [$0.title, $0.summary, $0.category, $0.family, $0.apis.joined(separator: " ")]
                .joined(separator: " ").localizedCaseInsensitiveContains(query)
        }
    }

    private var categories: [String] {
        filtered.reduce(into: []) { if !$0.contains($1.category) { $0.append($1.category) } }
    }

    var body: some View {
        if ProcessInfo.processInfo.arguments.contains("--capture"), let entry = requestedEntry {
            Group {
                if entry.captureNavigation {
                    NavigationStack { AtlasCatalog.demo(for: entry.id) }
                } else {
                    AtlasCatalog.demo(for: entry.id)
                }
            }
            .preferredColorScheme(.light)
            .dynamicTypeSize(.large)
            .statusBarHidden()
        } else {
            catalog
        }
    }

    private var catalog: some View {
        NavigationStack(path: $path) {
            List {
                Section {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("iOS Design Atlas").font(.title2.bold())
                        Text("A field guide to native interfaces.").foregroundStyle(.secondary)
                        Text("\(AtlasCatalog.entries.count) EXAMPLES")
                            .font(.caption.monospaced()).foregroundStyle(.secondary)
                    }.padding(.vertical, 8)
                }
                ForEach(categories, id: \.self) { category in
                    Section(category) {
                        ForEach(filtered.filter { $0.category == category }) { entry in
                            NavigationLink(value: entry.id) {
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(entry.title).font(.headline)
                                    Text(entry.summary).font(.subheadline).foregroundStyle(.secondary)
                                    if !entry.isSupported {
                                        Text("iOS \(entry.minimumOS)+").font(.caption).foregroundStyle(.secondary)
                                    }
                                }.padding(.vertical, 5)
                            }.accessibilityIdentifier("entry-\(entry.id)")
                        }
                    }
                }
            }
            .overlay {
                if filtered.isEmpty { ContentUnavailableView.search(text: query) }
            }
            .navigationTitle("Atlas")
            .searchable(text: $query, prompt: "Search examples or APIs")
            .navigationDestination(for: String.self) { id in
                if AtlasCatalog.entries.first(where: { $0.id == id })?.ownsNavigation == true {
                    AtlasCatalog.demo(for: id)
                        .safeAreaInset(edge: .top, spacing: 0) {
                            HStack {
                                Button { path = [] } label: { Label("Atlas", systemImage: "chevron.left") }
                                    .accessibilityIdentifier("back-to-atlas")
                                Spacer()
                            }
                            .font(.subheadline).padding(.horizontal).padding(.vertical, 8)
                            .background(.bar)
                        }
                        .toolbar(.hidden, for: .navigationBar)
                } else {
                    AtlasCatalog.demo(for: id)
                }
            }
            .onAppear {
                if path.isEmpty, let entry = requestedEntry { path = [entry.id] }
            }
        }
    }
}

#Preview { ContentView() }

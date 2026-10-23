import SwiftUI

struct ContentView: View {
    @State private var query = ""
    @State private var path: [String] = []

    private var captureEntry: String? {
        let args = ProcessInfo.processInfo.arguments
        guard args.contains("--capture"),
              let index = args.firstIndex(of: "--entry"),
              args.indices.contains(index + 1),
              ["alert-actions", "alert-text-fields"].contains(args[index + 1]) else { return nil }
        return args[index + 1]
    }

    private var filtered: [AtlasEntry] {
        guard !query.isEmpty else { return AtlasCatalog.entries }
        return AtlasCatalog.entries.filter {
            [$0.title, $0.summary, $0.family, $0.apis.joined(separator: " ")]
                .joined(separator: " ").localizedCaseInsensitiveContains(query)
        }
    }

    var body: some View {
        if let captureEntry {
            AtlasCatalog.demo(for: captureEntry)
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
                        Text("A field guide to native interfaces.")
                            .foregroundStyle(.secondary)
                        Text("01 / PRESENTATION")
                            .font(.caption.monospaced()).foregroundStyle(.indigo)
                    }.padding(.vertical, 8)
                }
                Section("\(filtered.count) examples") {
                    ForEach(filtered) { entry in
                        NavigationLink(value: entry.id) {
                            VStack(alignment: .leading, spacing: 5) {
                                Text(entry.title).font(.headline)
                                Text(entry.summary).font(.subheadline).foregroundStyle(.secondary)
                            }.padding(.vertical, 5)
                        }.accessibilityIdentifier("entry-\(entry.id)")
                    }
                }
            }
            .overlay {
                if filtered.isEmpty { ContentUnavailableView.search(text: query) }
            }
            .navigationTitle("Atlas")
            .searchable(text: $query, prompt: "Search examples or APIs")
            .navigationDestination(for: String.self) { id in
                AtlasCatalog.demo(for: id)
            }
            .onAppear {
                let args = ProcessInfo.processInfo.arguments
                if let index = args.firstIndex(of: "--entry"), args.indices.contains(index + 1), path.isEmpty {
                    let id = args[index + 1]
                    if AtlasCatalog.entries.contains(where: { $0.id == id }) { path = [id] }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

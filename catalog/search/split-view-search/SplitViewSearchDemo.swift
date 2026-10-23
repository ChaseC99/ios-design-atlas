import SwiftUI

struct SplitViewSearchDemo: View {
    @State private var folder: String? = "Travel"
    @State private var query = "coast"
    @State private var compactColumn: NavigationSplitViewColumn = .detail
    private let entries: [String: [String]] = ["Travel": ["Northern coast", "Coastal trail", "Mountain route", "City weekends"], "Personal": ["Morning pages", "Coastal memories", "Good things to keep"]]
    private var results: [String] { (entries[folder ?? ""] ?? []).filter { query.isEmpty || $0.localizedCaseInsensitiveContains(query) } }
    var body: some View {
        NavigationSplitView(preferredCompactColumn: $compactColumn) {
            List(entries.keys.sorted(), id: \.self, selection: $folder) { title in
                NavigationLink(value: title) { Label(title, systemImage: "folder") }
            }.navigationTitle("Collections")
        } detail: {
            if let folder {
                List(results, id: \.self) { title in
                    NavigationLink {
                        Text(title).font(.largeTitle).padding().navigationTitle("Note").navigationBarTitleDisplayMode(.inline)
                    } label: {
                        VStack(alignment: .leading, spacing: 7) {
                            Text(title).font(.headline)
                            Text(folder).font(.caption).foregroundStyle(.secondary)
                        }.padding(.vertical, 9)
                    }
                }
                .overlay { if results.isEmpty { ContentUnavailableView.search(text: query) } }
                .navigationTitle(folder)
                .searchable(text: $query, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search \(folder)")
            } else {
                ContentUnavailableView("Choose a collection", systemImage: "folder")
            }
        }
        .accessibilityIdentifier("capture-ready")
    }
}

#Preview { SplitViewSearchDemo() }

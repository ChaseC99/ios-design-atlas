import SwiftUI

struct SearchHighlightingGroupsDemo: View {
    @State private var query = "coast"
    private let groups: [(String, [String])] = [
        ("Places", ["Northern coast", "Coastal trail", "City garden"]),
        ("Collections", ["A weekend on the coast", "Coastline favorites", "Quiet mornings"]),
        ("Notes", ["A coast-to-coast adventure", "The slower route"])
    ]
    private var filtered: [(String, [String])] { groups.compactMap { title, values in
        let matches = values.filter { query.isEmpty || $0.localizedCaseInsensitiveContains(query) }
        return matches.isEmpty ? nil : (title, matches)
    } }
    var body: some View {
        List {
            ForEach(filtered, id: \.0) { category, values in
                Section(category) {
                    ForEach(values, id: \.self) { value in
                        HStack(spacing: 12) {
                            Image(systemName: category == "Places" ? "mappin.circle" : category == "Collections" ? "folder" : "note.text").foregroundStyle(.secondary)
                            Text(highlighted(value))
                        }.padding(.vertical, 12)
                    }
                }
            }
        }
        .overlay { if filtered.isEmpty { ContentUnavailableView.search(text: query) } }
        .navigationTitle("Library search")
        .searchable(text: $query, placement: .navigationBarDrawer(displayMode: .always))
        .accessibilityIdentifier("capture-ready")
    }
    private func highlighted(_ value: String) -> AttributedString {
        var result = AttributedString(value)
        guard !query.isEmpty else { return result }
        var searchRange = value.startIndex..<value.endIndex
        while let range = value.range(of: query, options: [.caseInsensitive, .diacriticInsensitive], range: searchRange) {
            if let lower = AttributedString.Index(range.lowerBound, within: result), let upper = AttributedString.Index(range.upperBound, within: result) {
                result[lower..<upper].font = .body.bold()
                result[lower..<upper].foregroundColor = .indigo
            }
            guard range.upperBound < value.endIndex else { break }
            searchRange = range.upperBound..<value.endIndex
        }
        return result
    }
}

#Preview { NavigationStack { SearchHighlightingGroupsDemo() } }

import SwiftUI
import UIKit

struct HostingConfigurationCellsDemo: View {
    @State private var saved: Set<Int> = [0, 2]
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Keep a little inspiration.").font(.system(.largeTitle, design: .serif).bold())
                Text("\(saved.count) places saved").foregroundStyle(.secondary)
            }.padding(24)
            PlacesTable(saved: $saved)
        }
        .background(Color(uiColor: .systemGroupedBackground))
        .navigationTitle("Saved places").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
    private struct PlacesTable: UIViewRepresentable {
        @Binding var saved: Set<Int>
        func makeCoordinator() -> Coordinator { Coordinator(saved: $saved) }
        func makeUIView(context: Context) -> UITableView {
            let table = UITableView(frame: .zero, style: .insetGrouped)
            table.register(UITableViewCell.self, forCellReuseIdentifier: "place")
            table.dataSource = context.coordinator; table.delegate = context.coordinator
            table.rowHeight = UITableView.automaticDimension; table.estimatedRowHeight = 90
            return table
        }
        func updateUIView(_ table: UITableView, context: Context) {
            context.coordinator.saved = $saved; table.reloadData()
        }
        static func dismantleUIView(_ table: UITableView, coordinator: Coordinator) { table.dataSource = nil; table.delegate = nil }
        @MainActor final class Coordinator: NSObject, UITableViewDataSource, UITableViewDelegate {
            var saved: Binding<Set<Int>>
            private let places = [("Cypress Point", "A little room to breathe", "water.waves"), ("Fern Grove", "An afternoon under the trees", "tree.fill"), ("North Beach", "Take the long way home", "sun.horizon.fill"), ("The Reading Room", "Stay for one more chapter", "books.vertical.fill")]
            init(saved: Binding<Set<Int>>) { self.saved = saved }
            func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { places.count }
            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let cell = tableView.dequeueReusableCell(withIdentifier: "place", for: indexPath)
                let place = places[indexPath.row]; let selected = saved.wrappedValue.contains(indexPath.row)
                cell.contentConfiguration = UIHostingConfiguration {
                    HStack(spacing: 16) {
                        Image(systemName: place.2).font(.title2).foregroundStyle(.teal).frame(width: 36)
                        VStack(alignment: .leading, spacing: 6) { Text(place.0).font(.headline); Text(place.1).font(.subheadline).foregroundStyle(.secondary) }
                        Spacer(minLength: 8)
                        Image(systemName: selected ? "bookmark.fill" : "bookmark").foregroundStyle(.teal)
                    }.accessibilityElement(children: .combine)
                }.margins(.all, 18)
                cell.accessibilityHint = selected ? "Double-tap to remove from saved places" : "Double-tap to save this place"
                return cell
            }
            func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                tableView.deselectRow(at: indexPath, animated: true)
                if saved.wrappedValue.contains(indexPath.row) { saved.wrappedValue.remove(indexPath.row) }
                else { saved.wrappedValue.insert(indexPath.row) }
            }
        }
    }
}

#Preview { NavigationStack { HostingConfigurationCellsDemo() } }

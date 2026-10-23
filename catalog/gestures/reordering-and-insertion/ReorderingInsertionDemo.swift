import SwiftUI

struct ReorderingInsertionDemo: View {
    @State private var items = ["Harbor walk", "Forest trail", "Mountain lookout", "Riverside picnic"]
    @State private var editMode = EditMode.active
    @State private var outcome = "4 stops planned"
    private let extra = "Garden café"
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 16) {
                Label(extra, systemImage: "cup.and.saucer.fill").font(.headline)
                    .padding(18).background(.teal.opacity(0.1), in: .rect(cornerRadius: 18))
                    .draggable(extra)
                Spacer()
                Button("Add") { insert([extra], at: items.count) }.disabled(items.contains(extra))
            }.padding(20)
            List {
                Section("Weekend itinerary") {
                    ForEach(items, id: \.self) { item in
                        Label(item, systemImage: symbol(item)).padding(.vertical, 8)
                            .accessibilityAction(named: "Move earlier") { move(item, by: -1) }
                            .accessibilityAction(named: "Move later") { move(item, by: 1) }
                    }
                    .onMove { offsets, destination in
                        items.move(fromOffsets: offsets, toOffset: destination)
                        outcome = "Itinerary reordered"
                    }
                    .dropDestination(for: String.self) { values, index in insert(values, at: index) }
                }
                Section { Text(outcome).foregroundStyle(.secondary) }
            }
            .environment(\.editMode, $editMode)
        }
        .navigationTitle("Reordering and insertion").navigationBarTitleDisplayMode(.inline)
        .toolbar { Button(editMode == .active ? "Done" : "Reorder") { editMode = editMode == .active ? .inactive : .active } }
        .accessibilityIdentifier("capture-ready")
    }
    private func insert(_ values: [String], at index: Int) {
        let additions = Array(Set(values)).filter { $0 == extra && !items.contains($0) }
        guard !additions.isEmpty else { return }
        items.insert(contentsOf: additions, at: min(max(0, index), items.count))
        outcome = "Added \(extra)"
    }
    private func move(_ item: String, by delta: Int) {
        guard let from = items.firstIndex(of: item), items.indices.contains(from + delta) else { return }
        items.swapAt(from, from + delta)
        outcome = "Moved \(item) \(delta < 0 ? "earlier" : "later")"
    }
    private func symbol(_ item: String) -> String {
        switch item { case "Harbor walk": "water.waves"; case "Forest trail": "tree"; case "Mountain lookout": "mountain.2"; case "Garden café": "cup.and.saucer"; default: "basket" }
    }
}

#Preview { NavigationStack { ReorderingInsertionDemo() } }

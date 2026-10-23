import SwiftUI

@available(iOS 27.0, *)
struct MultiItemDraggingDemo: View {
    private let items = ["Harbor light", "Forest air", "Mountain morning", "Desert dusk"]
    @State private var selection: Set<String> = ["Harbor light", "Forest air"]
    @State private var received = ["Desert dusk"]
    @State private var phase = "Ready"
    @State private var targeted = false
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                HStack {
                    Text("A collection of places").font(.title.bold())
                    Spacer()
                    Text("\(selection.count) selected").font(.caption).foregroundStyle(.secondary)
                }
                VStack(spacing: 10) {
                    ForEach(items, id: \.self) { item in
                        HStack(spacing: 16) {
                            Image(systemName: "photo.on.rectangle").font(.title2).foregroundStyle(.teal)
                            Text(item).font(.headline)
                            Spacer()
                            Button {
                                if selection.contains(item) { selection.remove(item) } else { selection.insert(item) }
                            } label: {
                                Image(systemName: selection.contains(item) ? "checkmark.circle.fill" : "circle").font(.title2)
                            }
                            .accessibilityLabel("Select \(item)")
                            .accessibilityValue(selection.contains(item) ? "Selected" : "Not selected")
                        }
                        .padding(18).background(selection.contains(item) ? .teal.opacity(0.1) : Color(.secondarySystemBackground), in: .rect(cornerRadius: 18))
                        .draggable(containerItemID: item)
                    }
                }
                .dragContainer(for: String.self, itemID: \.self) { (ids: [String]) in ids }
                .dragContainerSelection(items.filter { selection.contains($0) })
                .onDragSessionUpdated { session in
                    switch session.phase {
                    case .initial: phase = "Preparing drag"
                    case .active: phase = "Dragging"
                    case .ending: phase = "Finishing drag"
                    case .ended(let operation): phase = operation == .cancel ? "Drag cancelled · Sources kept" : "Drag ended"
                    case .dataTransferCompleted: phase = "Transfer complete"
                    @unknown default: phase = "Session updated"
                    }
                }
                VStack(alignment: .leading, spacing: 14) {
                    Label("Saved together", systemImage: "tray.full.fill").font(.headline)
                    ForEach(received, id: \.self) { Text($0).foregroundStyle(.secondary) }
                    if received.isEmpty { Text("Drop a selection here").foregroundStyle(.secondary) }
                }
                .frame(maxWidth: .infinity, minHeight: 140, alignment: .topLeading).padding(22)
                .background(targeted ? .teal.opacity(0.12) : Color(.secondarySystemBackground), in: .rect(cornerRadius: 22))
                .overlay { RoundedRectangle(cornerRadius: 22).strokeBorder(targeted ? .teal : .secondary.opacity(0.2), style: StrokeStyle(lineWidth: 2, dash: [6])) }
                .dropDestination(for: String.self) { values, _ in accept(values) } isTargeted: { targeted = $0 }
                Button("Add selected") { _ = accept(items.filter { selection.contains($0) }) }
                    .buttonStyle(.borderedProminent).disabled(selection.isEmpty)
                LabeledContent("Session", value: phase).font(.subheadline)
            }.padding(24)
        }
        .navigationTitle("Multi-item dragging").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
    private func accept(_ values: [String]) -> Bool {
        let additions = items.filter { values.contains($0) && !received.contains($0) }
        guard !additions.isEmpty else { return false }
        received.append(contentsOf: additions)
        phase = "\(additions.count) \(additions.count == 1 ? "item" : "items") added"
        return true
    }
}

#Preview { if #available(iOS 27.0, *) { NavigationStack { MultiItemDraggingDemo() } } }

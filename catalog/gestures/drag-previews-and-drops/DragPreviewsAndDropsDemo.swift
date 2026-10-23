import SwiftUI

struct DragPreviewsAndDropsDemo: View {
    private let available = ["Harbor light", "Quiet forest", "Mountain air"]
    @State private var saved = ["Mountain air"]
    @State private var targeted = false
    @State private var status = "1 item collected"
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Text("Places to keep").font(.largeTitle.bold())
                VStack(spacing: 12) {
                    ForEach(available, id: \.self) { item in
                        HStack(spacing: 16) {
                            Image(systemName: symbol(item)).font(.title).foregroundStyle(.teal).frame(width: 44)
                            Text(item).font(.headline)
                            Spacer()
                            Button { _ = accept([item]) } label: {
                                Image(systemName: saved.contains(item) ? "checkmark.circle.fill" : "plus.circle")
                            }
                            .accessibilityLabel("Add \(item)")
                            .disabled(saved.contains(item))
                        }
                        .padding(18).background(.teal.opacity(0.07), in: .rect(cornerRadius: 18))
                        .draggable(item) {
                            Label(item, systemImage: symbol(item)).font(.headline)
                                .padding(20).background(.regularMaterial, in: .rect(cornerRadius: 18))
                        }
                    }
                }
                VStack(alignment: .leading, spacing: 18) {
                    HStack {
                        Label("Weekend collection", systemImage: "tray.full.fill").font(.headline)
                        Spacer()
                        Text("\(saved.count)").foregroundStyle(.secondary)
                    }
                    ForEach(saved, id: \.self) { item in
                        Label(item, systemImage: symbol(item)).foregroundStyle(.teal)
                    }
                    if saved.isEmpty { Text("Drop a place here").foregroundStyle(.secondary) }
                    Text(targeted ? "Release to add" : status).font(.caption).foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, minHeight: 180, alignment: .topLeading)
                .padding(22)
                .background(targeted ? Color.teal.opacity(0.12) : Color(.secondarySystemBackground), in: .rect(cornerRadius: 24))
                .overlay { RoundedRectangle(cornerRadius: 24).strokeBorder(targeted ? .teal : .secondary.opacity(0.2), style: StrokeStyle(lineWidth: 2, dash: [6])) }
                .dropDestination(for: String.self) { values, _ in accept(values) } isTargeted: { targeted = $0 }
                Button("Empty collection") { saved = []; status = "Ready for your first place" }.disabled(saved.isEmpty)
            }.padding(24)
        }
        .navigationTitle("Drag and drop").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
    private func accept(_ values: [String]) -> Bool {
        let accepted = Array(Set(values)).filter { available.contains($0) && !saved.contains($0) }.sorted()
        guard !accepted.isEmpty else { return false }
        saved.append(contentsOf: accepted)
        status = "\(saved.count) \(saved.count == 1 ? "item" : "items") collected"
        return true
    }
    private func symbol(_ item: String) -> String {
        switch item { case "Harbor light": "sun.horizon.fill"; case "Quiet forest": "tree.fill"; default: "mountain.2.fill" }
    }
}

#Preview { NavigationStack { DragPreviewsAndDropsDemo() } }

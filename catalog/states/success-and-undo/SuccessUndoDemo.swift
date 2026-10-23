import SwiftUI

struct SuccessUndoDemo: View {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var items = ["Harbor walk", "Forest trail", "Mountain lookout", "Riverside picnic"]
    @State private var removed: (name: String, index: Int)?
    @State private var status = "4 places saved"
    @State private var captured = false
    var body: some View {
        List {
            Section {
                VStack(alignment: .leading, spacing: 12) {
                    Image(systemName: "bookmark.fill").font(.largeTitle).foregroundStyle(.teal)
                    Text("Weekend places").font(.title.bold())
                    Text(status).foregroundStyle(.secondary)
                }.padding(.vertical, 16)
            }
            Section {
                ForEach(items, id: \.self) { item in
                    HStack(spacing: 16) {
                        Image(systemName: symbol(item)).font(.title2).foregroundStyle(.teal).frame(width: 36)
                        Text(item).font(.headline)
                    }.padding(.vertical, 14)
                        .swipeActions { Button("Remove", role: .destructive) { remove(item, animated: true) } }
                        .accessibilityAction(named: "Remove") { remove(item, animated: true) }
                }
            }
            Section {
                Button("Remove the last place", role: .destructive) {
                    if let last = items.last { remove(last, animated: true) }
                }.disabled(items.isEmpty)
                Button("Reset collection") {
                    items = ["Harbor walk", "Forest trail", "Mountain lookout", "Riverside picnic"]
                    removed = nil; status = "4 places saved"
                }
            }
        }
        .safeAreaInset(edge: .bottom, spacing: 0) {
            if let previous = removed {
                HStack(spacing: 16) {
                    Image(systemName: "checkmark.circle.fill").foregroundStyle(.teal)
                    VStack(alignment: .leading, spacing: 3) {
                        Text("Place removed").font(.headline)
                        Text(previous.name).font(.caption).foregroundStyle(.secondary)
                    }
                    Spacer()
                    Button("Undo") { undo() }.fontWeight(.semibold)
                }
                .padding(20).frame(maxWidth: .infinity).background(.regularMaterial)
            }
        }
        .navigationTitle("Success and undo").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
        .task {
            if ProcessInfo.processInfo.arguments.contains("--capture"), !captured {
                captured = true
                remove("Riverside picnic", animated: false)
            }
        }
    }
    private func remove(_ item: String, animated: Bool) {
        guard let index = items.firstIndex(of: item) else { return }
        withAnimation(animated && !reduceMotion ? .snappy : nil) {
            removed = (item, index); items.remove(at: index)
            status = "\(items.count) places saved"
        }
    }
    private func undo() {
        guard let previous = removed else { return }
        withAnimation(reduceMotion ? nil : .snappy) {
            items.insert(previous.name, at: min(previous.index, items.count))
            removed = nil; status = "\(previous.name) restored"
        }
    }
    private func symbol(_ item: String) -> String {
        switch item { case "Harbor walk": "water.waves"; case "Forest trail": "tree"; case "Mountain lookout": "mountain.2"; default: "basket" }
    }
}

#Preview { NavigationStack { SuccessUndoDemo() } }

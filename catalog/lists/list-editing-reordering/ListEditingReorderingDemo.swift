import SwiftUI

struct ListEditingReorderingDemo: View {
    @State private var items = ["Find a new café", "Take the coastal path", "Read a chapter", "Make something by hand", "Leave room for the unexpected"]
    @State private var editMode: EditMode = ProcessInfo.processInfo.arguments.contains("--capture") ? .active : .inactive
    @State private var nextNumber = 1
    var body: some View {
        List {
            Section {
                ForEach(items, id: \.self) { item in
                    HStack(alignment: .firstTextBaseline, spacing: 14) {
                        Image(systemName: "circle").foregroundStyle(.teal)
                        Text(item).padding(.vertical, 10)
                    }
                }
                .onDelete { offsets in withAnimation { items.remove(atOffsets: offsets) } }
                .onMove { offsets, destination in items.move(fromOffsets: offsets, toOffset: destination) }
            } header: { Text("Make time for") } footer: { Text("A little list for a slower weekend.") }
        }
        .overlay { if items.isEmpty { ContentUnavailableView("A fresh start", systemImage: "checklist", description: Text("Add a new idea with the plus button.")) } }
        .navigationTitle("Weekend plans")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) { EditButton() }
            ToolbarItem(placement: .bottomBar) {
                Button("Add idea", systemImage: "plus") {
                    withAnimation { items.append("New idea \(nextNumber)"); nextNumber += 1 }
                }
            }
        }
        .environment(\.editMode, $editMode)
        .accessibilityIdentifier("capture-ready")
    }
}

#Preview { NavigationStack { ListEditingReorderingDemo() } }

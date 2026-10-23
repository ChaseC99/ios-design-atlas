import SwiftUI

struct NativeMenusDemo: View {
    private let isCapturing = ProcessInfo.processInfo.arguments.contains("--capture")
    @State private var sort = "Newest"
    @State private var pinned = false
    @State private var outcome = "Weekend references"

    var body: some View {
        VStack(spacing: 28) {
            if !isCapturing {
                Image(systemName: "folder.fill").font(.system(size: 64)).foregroundStyle(.orange)
                Text(outcome).font(.title2.bold())
            }
            Menu {
                Section {
                    Button("Open collection", systemImage: "folder") { outcome = "Collection opened" }
                        .accessibilityIdentifier("capture-ready")
                    Button("Make a copy", systemImage: "doc.on.doc") { outcome = "Weekend references copy" }
                }
                Section {
                    Toggle("Pin collection", systemImage: "pin", isOn: $pinned)
                    Menu("Sort by", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort order", selection: $sort) {
                            Text("Newest").tag("Newest")
                            Text("Title").tag("Title")
                            Text("Recently edited").tag("Recently edited")
                        }
                    }
                }
                Section {
                    Button("Delete collection", role: .destructive) { outcome = "Demo collection deleted" }
                }
            } label: {
                Label("Collection actions", systemImage: "ellipsis.circle")
            }
            .menuOrder(.fixed)
            .buttonStyle(.bordered)
            .accessibilityIdentifier("capture-open")
            if !isCapturing {
                Text("Sorted by \(sort.lowercased())").foregroundStyle(.secondary)
            }
        }
        .padding(28).frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(uiColor: .systemBackground))
        .navigationTitle("Sections and nested menus")
    }
}

#Preview { NavigationStack { NativeMenusDemo() } }

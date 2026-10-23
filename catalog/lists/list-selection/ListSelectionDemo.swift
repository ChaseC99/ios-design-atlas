import SwiftUI

struct ListSelectionDemo: View {
    @State private var multiple = true
    @State private var selection: Set<String> = ["Quiet mornings", "Open water"]
    @State private var singleSelection: String? = "Quiet mornings"
    @State private var favorites: Set<String> = []
    private let isCapturing = ProcessInfo.processInfo.arguments.contains("--capture")
    private let titles = ["Quiet mornings", "A little further", "Open water", "Something worth keeping", "The long way home", "Under the same sky"]
    var body: some View {
        Group {
            if multiple {
                List(titles, id: \.self, selection: $selection) { title in row(title).tag(title) }
                    .environment(\.editMode, .constant(.active))
            } else {
                List(titles, id: \.self, selection: $singleSelection) { title in row(title).tag(title) }
            }
        }
        .safeAreaInset(edge: .top) {
            if !isCapturing {
                Picker("Selection", selection: $multiple) { Text("Single").tag(false); Text("Multiple").tag(true) }
                    .pickerStyle(.segmented).padding().background(.bar)
            }
        }
        .safeAreaInset(edge: .bottom) {
            HStack {
                Text("\(multiple ? selection.count : (singleSelection == nil ? 0 : 1)) selected").foregroundStyle(.secondary)
                Spacer()
                Button("Favorite", systemImage: "star") {
                    favorites.formUnion(multiple ? selection : Set([singleSelection].compactMap { $0 }))
                }.buttonStyle(.bordered).disabled(multiple ? selection.isEmpty : singleSelection == nil)
            }.padding().background(.bar)
        }
        .navigationTitle("Select notes")
        .accessibilityIdentifier("capture-ready")
    }
    private func row(_ title: String) -> some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 6) {
                Text(title).font(.headline)
                Text("Personal · Updated today").font(.caption).foregroundStyle(.secondary)
            }
            Spacer()
            if favorites.contains(title) { Image(systemName: "star.fill").foregroundStyle(.orange).accessibilityLabel("Favorite") }
        }.padding(.vertical, 10)
    }
}

#Preview { NavigationStack { ListSelectionDemo() } }

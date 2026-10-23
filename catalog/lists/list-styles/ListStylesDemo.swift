import SwiftUI

struct ListStylesDemo: View {
    @State private var style = 2
    private let isCapturing = ProcessInfo.processInfo.arguments.contains("--capture")
    var body: some View {
        Group {
            switch style {
            case 0: collection.listStyle(.plain)
            case 1: collection.listStyle(.grouped)
            default: collection.listStyle(.insetGrouped)
            }
        }
        .safeAreaInset(edge: .top) {
            if !isCapturing {
                Picker("Style", selection: $style) {
                    Text("Plain").tag(0); Text("Grouped").tag(1); Text("Inset").tag(2)
                }.pickerStyle(.segmented).padding().background(.bar)
            }
        }
        .navigationTitle("Collections")
        .accessibilityIdentifier("capture-ready")
    }
    private var collection: some View {
        List {
            Section {
                collectionRow("Morning rituals", symbol: "sun.horizon", count: 8, color: .orange)
                collectionRow("Places to return to", symbol: "map", count: 12, color: .teal)
                collectionRow("Small adventures", symbol: "leaf", count: 6, color: .green)
            } header: { Text("Pinned") } footer: { Text("Your favorites, always close by.") }
            Section("Recently added") {
                collectionRow("A slower weekend", symbol: "cup.and.saucer", count: 4, color: .brown)
                collectionRow("Reading between the lines", symbol: "book", count: 9, color: .indigo)
                collectionRow("After the rain", symbol: "cloud.rain", count: 3, color: .blue)
            }
        }
    }
    private func collectionRow(_ title: String, symbol: String, count: Int, color: Color) -> some View {
        NavigationLink {
            ContentUnavailableView(title, systemImage: symbol, description: Text("\(count) saved references."))
                .navigationTitle(title).navigationBarTitleDisplayMode(.inline)
        } label: {
            HStack(spacing: 13) {
                Image(systemName: symbol).foregroundStyle(color).frame(width: 26)
                Text(title)
                Spacer()
                Text(count, format: .number).foregroundStyle(.secondary).font(.subheadline)
            }.padding(.vertical, 7)
        }
    }
}

#Preview { NavigationStack { ListStylesDemo() } }

import SwiftUI

struct PreservingScrollTargetDemo: View {
    @State private var items = Array(21...60)
    @State private var anchoredID: Int? = 21
    @State private var preserve = true
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                LazyVStack(spacing: 14) {
                    ForEach(items, id: \.self) { number in
                        HStack(spacing: 20) {
                            Text(String(format: "%02d", number)).font(.system(.title, design: .serif)).foregroundStyle(.orange)
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Journal entry \(number)").font(.headline)
                                Text("A moment worth keeping.").font(.subheadline).foregroundStyle(.secondary)
                            }
                            Spacer()
                        }.padding(24).background(Color.orange.opacity(0.07), in: RoundedRectangle(cornerRadius: 22)).id(number)
                    }
                }.scrollTargetLayout().padding(24)
            }
            .scrollPosition(id: $anchoredID, anchor: .top)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Toggle("Preserve anchored row", isOn: $preserve)
                    } label: { Label("Options", systemImage: "ellipsis") }
                }
                ToolbarItem(placement: .bottomBar) {
                    Button("Load earlier entries", systemImage: "arrow.up") {
                        guard let first = items.first, first > 1 else { return }
                        let anchor = anchoredID
                        items.insert(contentsOf: Array(max(1, first - 10)..<first), at: 0)
                        if preserve, let anchor {
                            Task { @MainActor in
                                await Task.yield()
                                proxy.scrollTo(anchor, anchor: .top)
                            }
                        } else {
                            anchoredID = items.first
                        }
                    }.disabled(items.first == 1)
                }
            }
        }
        .navigationTitle("Journal archive").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
}
#Preview { NavigationStack { PreservingScrollTargetDemo() } }

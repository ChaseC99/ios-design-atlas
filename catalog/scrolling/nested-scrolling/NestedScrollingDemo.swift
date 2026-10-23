import SwiftUI

struct NestedScrollingDemo: View {
    @State private var selected: String?
    private let shelves = ["Morning light", "By the water", "After hours", "Small details"]
    private let colors: [Color] = [.orange, .teal, .indigo, .pink]
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 34) {
                Text("A little\ninspiration.").font(.system(.largeTitle, design: .serif)).padding(.horizontal, 24)
                ForEach(Array(shelves.enumerated()), id: \.offset) { section, title in
                    VStack(alignment: .leading, spacing: 16) {
                        Text(title).font(.title2.weight(.semibold)).padding(.horizontal, 24)
                        ScrollView(.horizontal) {
                            LazyHStack(spacing: 16) {
                                ForEach(0..<6) { item in
                                    let name = "\(title) \(item + 1)"
                                    Button { selected = name } label: {
                                        VStack(alignment: .leading, spacing: 12) {
                                            RoundedRectangle(cornerRadius: 24).fill(colors[section].gradient).frame(height: 164)
                                                .overlay(Image(systemName: ["sun.max", "water.waves", "moon.stars", "leaf"][section])
                                                    .font(.system(size: 50, weight: .ultraLight)).foregroundStyle(.white))
                                            Text("Study \(item + 1)").font(.headline)
                                            Text("Saved inspiration").font(.caption).foregroundStyle(.secondary)
                                        }.frame(width: 216)
                                    }.buttonStyle(.plain)
                                }
                            }.scrollTargetLayout()
                        }.contentMargins(.horizontal, 24, for: .scrollContent)
                            .scrollTargetBehavior(.viewAligned).scrollIndicators(.hidden)
                    }
                }
            }.padding(.vertical, 24)
        }
        .navigationTitle("Discover").navigationBarTitleDisplayMode(.inline)
        .sheet(item: Binding(get: { selected.map(Selection.init) }, set: { selected = $0?.name })) { selection in
            VStack(spacing: 24) {
                Image(systemName: "sparkles").font(.largeTitle).foregroundStyle(.orange)
                Text(selection.name).font(.title2)
                Button("Done") { selected = nil }.buttonStyle(.bordered)
            }.presentationDetents([.medium])
        }
        .accessibilityIdentifier("capture-ready")
    }
    private struct Selection: Identifiable { var name: String; var id: String { name } }
}
#Preview { NavigationStack { NestedScrollingDemo() } }

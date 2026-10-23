import SwiftUI

struct GridSelectionDemo: View {
    @State private var selected: Set<Int> = [1, 4]
    @State private var selectionMode = true
    @State private var saved: Set<Int> = []
    @State private var count = 12
    private let isCapturing = ProcessInfo.processInfo.arguments.contains("--capture")
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 110), spacing: 6)], spacing: 6) {
                ForEach(0..<count, id: \.self) { index in
                    Button {
                        if selected.contains(index) { selected.remove(index) } else { selected.insert(index) }
                    } label: {
                        ZStack {
                            Rectangle().fill([Color.orange, .indigo, .teal, .pink, .blue, .brown][index % 6].gradient)
                            Image(systemName: ["sun.horizon.fill", "moon.stars.fill", "leaf.fill", "cloud.sun.fill", "water.waves", "mountain.2.fill"][index % 6])
                                .font(.system(size: 38)).foregroundStyle(.white.opacity(0.9))
                        }
                        .aspectRatio(1, contentMode: .fit)
                        .overlay(alignment: .bottomTrailing) {
                            if selectionMode {
                                Image(systemName: selected.contains(index) ? "checkmark.circle.fill" : "circle")
                                    .font(.title3).symbolRenderingMode(.palette)
                                    .foregroundStyle(selected.contains(index) ? .blue : .white, .white)
                                    .padding(8).shadow(color: .black.opacity(0.25), radius: 3)
                            }
                        }
                        .overlay(alignment: .topLeading) {
                            if saved.contains(index) { Image(systemName: "star.fill").foregroundStyle(.white).padding(8).shadow(radius: 2) }
                        }
                        .clipShape(.rect(cornerRadius: 12))
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel("Artwork \(index + 1)")
                    .accessibilityValue(selected.contains(index) ? "Selected" : "Not selected")
                    .accessibilityAddTraits(selected.contains(index) ? [.isSelected] : [])
                    .disabled(!selectionMode)
                }
            }.padding(12)
        }
        .navigationTitle("Moments")
        .toolbar {
            if !isCapturing {
                ToolbarItem(placement: .topBarTrailing) { Button(selectionMode ? "Done" : "Select") { selectionMode.toggle() } }
            }
        }
        .safeAreaInset(edge: .bottom) {
            if selectionMode {
                HStack {
                    Text("\(selected.count) selected").foregroundStyle(.secondary)
                    Spacer()
                    Button("Favorite", systemImage: "star") { saved.formUnion(selected); selected.removeAll() }
                        .buttonStyle(.bordered).disabled(selected.isEmpty)
                }.padding().background(.bar)
            }
        }
        .accessibilityIdentifier("capture-ready")
    }
}

#Preview { NavigationStack { GridSelectionDemo() } }

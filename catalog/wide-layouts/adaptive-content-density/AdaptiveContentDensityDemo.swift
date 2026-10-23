import SwiftUI

struct AdaptiveContentDensityDemo: View {
    private let capturing = ProcessInfo.processInfo.arguments.contains("--capture")
    @State private var compact = false
    @State private var selection = "Coastal light"
    private let items = ["Coastal light", "City gardens", "Slow mornings", "Open water", "Quiet rooms", "Long weekends", "Mountain air", "Golden hour"]
    private let symbols = ["sun.horizon", "leaf", "cup.and.saucer", "water.waves", "chair.lounge", "calendar", "mountain.2", "sun.max"]
    private let colors: [Color] = [.teal, .green, .brown, .blue, .indigo, .purple, .orange, .pink]
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 28) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Collected moments").font(.system(.largeTitle, design: .serif))
                    Text("Small collections for a wider world.").foregroundStyle(.secondary)
                }
                LazyVGrid(columns: [GridItem(.adaptive(minimum: compact ? 140 : 180), spacing: 18)], spacing: 24) {
                    ForEach(items.indices, id: \.self) { index in
                        Button { selection = items[index] } label: {
                            VStack(alignment: .leading, spacing: 12) {
                                RoundedRectangle(cornerRadius: 20).fill(colors[index].gradient)
                                    .aspectRatio(1.2, contentMode: .fit)
                                    .overlay(Image(systemName: symbols[index]).font(.system(size: compact ? 36 : 44, weight: .light)).foregroundStyle(.white))
                                    .overlay(alignment: .topTrailing) {
                                        if selection == items[index] {
                                            Image(systemName: "checkmark.circle.fill").symbolRenderingMode(.palette)
                                                .foregroundStyle(.white, .black.opacity(0.55)).padding(12)
                                        }
                                    }
                                Text(items[index]).font(.headline).foregroundStyle(.primary)
                                Text("\(index + 3) ideas").font(.subheadline).foregroundStyle(.secondary)
                            }
                        }.buttonStyle(.plain).accessibilityAddTraits(selection == items[index] ? .isSelected : [])
                    }
                }
            }.padding(24).frame(maxWidth: 1100).frame(maxWidth: .infinity)
        }
        .navigationTitle("Collections").navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if !capturing {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(compact ? "Comfortable grid" : "Compact grid", systemImage: compact ? "square.grid.2x2" : "square.grid.3x3") { compact.toggle() }
                }
            }
        }
        .accessibilityIdentifier("capture-ready")
    }
}
#Preview { NavigationStack { AdaptiveContentDensityDemo() } }

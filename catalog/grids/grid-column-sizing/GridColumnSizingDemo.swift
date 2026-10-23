import SwiftUI

struct GridColumnSizingDemo: View {
    @State private var sizing = 2
    @State private var count = 11
    private let isCapturing = ProcessInfo.processInfo.arguments.contains("--capture")
    private var columns: [GridItem] {
        switch sizing {
        case 0: Array(repeating: GridItem(.fixed(90), spacing: 14), count: 3)
        case 1: Array(repeating: GridItem(.flexible(), spacing: 14), count: 2)
        default: [GridItem(.adaptive(minimum: 100), spacing: 14)]
        }
    }
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 18) {
                ForEach(0..<count, id: \.self) { index in
                    VStack(spacing: 10) {
                        RoundedRectangle(cornerRadius: 20)
                            .fill([Color.orange, .teal, .blue, .indigo, .brown, .cyan][index % 6].gradient)
                            .aspectRatio(1, contentMode: .fit)
                            .overlay {
                                Image(systemName: ["sun.horizon", "leaf", "water.waves", "moon.stars", "mountain.2", "cloud.sun"][index % 6])
                                    .font(.system(size: 32)).foregroundStyle(.white)
                            }
                        Text(["First light", "Slow days", "Open water", "After dark", "Higher ground", "Passing clouds"][index % 6])
                            .font(.caption.weight(.medium)).lineLimit(2).multilineTextAlignment(.center)
                    }
                }
            }.padding(20)
        }
        .overlay { if count == 0 { ContentUnavailableView("No artwork yet", systemImage: "square.grid.2x2", description: Text("Increase the item count to fill the grid.")) } }
        .safeAreaInset(edge: .top) {
            if !isCapturing {
                VStack(spacing: 12) {
                    Picker("Column sizing", selection: $sizing) { Text("Fixed").tag(0); Text("Flexible").tag(1); Text("Adaptive").tag(2) }.pickerStyle(.segmented)
                    Stepper("\(count) items", value: $count, in: 0...24)
                }.padding().background(.bar)
            }
        }
        .navigationTitle("Artwork")
        .accessibilityIdentifier("capture-ready")
    }
}

#Preview { NavigationStack { GridColumnSizingDemo() } }

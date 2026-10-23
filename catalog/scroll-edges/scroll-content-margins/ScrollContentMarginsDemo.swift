import SwiftUI

struct ScrollContentMarginsDemo: View {
    private let capturing = ProcessInfo.processInfo.arguments.contains("--capture")
    @State private var contentInset = 28.0
    @State private var indicatorInset = 2.0
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 26) {
                if !capturing {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Content: \(Int(contentInset)) pt").font(.caption)
                        Slider(value: $contentInset, in: 0...64, step: 4)
                        Text("Indicator: \(Int(indicatorInset)) pt").font(.caption)
                        Slider(value: $indicatorInset, in: 0...40, step: 2)
                    }
                }
                Text("The art of\nnoticing.").font(.system(.largeTitle, design: .serif, weight: .medium))
                RoundedRectangle(cornerRadius: 24).fill(.orange.gradient).frame(height: 220)
                    .overlay(Image(systemName: "sun.max").font(.system(size: 90, weight: .ultraLight)).foregroundStyle(.white))
                ForEach(0..<10) { index in
                    VStack(alignment: .leading, spacing: 10) {
                        Text(index == 0 ? "Look a little longer" : "A small observation").font(.title3.weight(.semibold))
                        Text("There is a moment when familiar things become interesting again. The line of a shadow, the shape of a leaf, the changing color of a quiet room. Give it a little room.")
                            .font(.body).lineSpacing(5).foregroundStyle(.secondary)
                    }
                }
            }.padding(.vertical, 28).frame(maxWidth: 640, alignment: .leading).frame(maxWidth: .infinity)
        }
        .contentMargins(.horizontal, contentInset, for: .scrollContent)
        .contentMargins(.trailing, indicatorInset, for: .scrollIndicators)
        .scrollIndicators(.visible)
        .background(Color.orange.opacity(0.035))
        .navigationTitle("Journal").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
}
#Preview { NavigationStack { ScrollContentMarginsDemo() } }

import SwiftUI

struct ScrollBounceIndicatorsDemo: View {
    private let capturing = ProcessInfo.processInfo.arguments.contains("--capture")
    @State private var longContent = false
    @State private var alwaysBounce = false
    @State private var indicators = true
    @State private var flash = 0
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 28) {
                RoundedRectangle(cornerRadius: 28).fill(.teal.gradient).frame(height: 220)
                    .overlay(Image(systemName: "water.waves").font(.system(size: 80, weight: .ultraLight)).foregroundStyle(.white))
                Text("Room to breathe.").font(.system(.largeTitle, design: .serif))
                Text("A short page can stay still when its content fits. Longer pages have room to move.")
                    .font(.title3).foregroundStyle(.secondary)
                if !capturing {
                    Toggle("Long content", isOn: $longContent)
                    Toggle("Always allow bounce", isOn: $alwaysBounce)
                    Toggle("Show scroll indicators", isOn: $indicators)
                    Button("Flash indicators") { flash += 1 }
                }
                if longContent {
                    ForEach(1...15, id: \.self) { number in
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Observation \(number)").font(.headline)
                            Text("Slow down. Look around. There is usually something worth noticing.").foregroundStyle(.secondary)
                        }.padding(.vertical, 12)
                    }
                }
            }.padding(28)
        }
        .scrollBounceBehavior(alwaysBounce ? .always : .basedOnSize)
        .scrollIndicators(indicators ? .visible : .hidden)
        .scrollIndicatorsFlash(trigger: flash)
        .contentMargins(.trailing, 4, for: .scrollIndicators)
        .navigationTitle("Quiet page").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
}
#Preview { NavigationStack { ScrollBounceIndicatorsDemo() } }

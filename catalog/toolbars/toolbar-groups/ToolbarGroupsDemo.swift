import SwiftUI

@available(iOS 26.0, *)
struct ToolbarGroupsDemo: View {
    private let capturing = ProcessInfo.processInfo.arguments.contains("--capture")
    @State private var separated = true
    @State private var showBackground = true
    @State private var bold = false
    @State private var italic = false
    @State private var size = 28.0
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 28) {
                Text("A note to\nyour future self.")
                    .font(.system(size: size, weight: bold ? .bold : .regular, design: .serif))
                    .italic(italic)
                Text("Remember how it felt to have nowhere else to be. Keep a little of that feeling for the busy days.")
                    .font(.title3).lineSpacing(6).foregroundStyle(.secondary)
                RoundedRectangle(cornerRadius: 28).fill(.orange.gradient).frame(height: 240)
                    .overlay(Image(systemName: "sun.max").font(.system(size: 78, weight: .ultraLight)).foregroundStyle(.white))
                if !capturing {
                    Toggle("Separate formatting groups", isOn: $separated)
                    Toggle("Show size group background", isOn: $showBackground)
                }
            }.padding(32)
        }
        .navigationTitle("Notebook").navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                Toggle("Bold", systemImage: "bold", isOn: $bold)
                Toggle("Italic", systemImage: "italic", isOn: $italic)
            }
            if separated { ToolbarSpacer(.fixed, placement: .bottomBar) }
            ToolbarItemGroup(placement: .bottomBar) {
                Button("Smaller", systemImage: "textformat.size.smaller") { size = max(20, size - 2) }
                Button("Larger", systemImage: "textformat.size.larger") { size = min(48, size + 2) }
            }.sharedBackgroundVisibility(showBackground ? .automatic : .hidden)
        }
        .accessibilityIdentifier("capture-ready")
    }
}
#Preview { if #available(iOS 26.0, *) { NavigationStack { ToolbarGroupsDemo() } } }

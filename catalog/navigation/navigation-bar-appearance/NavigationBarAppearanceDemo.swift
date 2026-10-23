import SwiftUI

struct NavigationBarAppearanceDemo: View {
    private let isCapturing = ProcessInfo.processInfo.arguments.contains("--capture")
    @State private var colored = true
    @State private var hidden = false
    @State private var darkBar = true
    @State private var warmAccent = false
    var body: some View {
        NavigationStack {
            List {
                if !isCapturing {
                    Section("Navigation bar") {
                        Toggle("Colored background", isOn: $colored)
                        Toggle("Dark color scheme", isOn: $darkBar)
                        Toggle("Hide navigation bar", isOn: $hidden)
                        Toggle("Orange accent", isOn: $warmAccent)
                    }
                }
                Section("Reading list") {
                    ForEach(["On noticing", "The art of taking your time", "A place of your own", "Everyday rituals", "A quieter kind of journey"], id: \.self) { title in
                        NavigationLink {
                            Text(title).font(.largeTitle).padding().navigationTitle("Essay").navigationBarTitleDisplayMode(.inline)
                        } label: {
                            VStack(alignment: .leading, spacing: 7) {
                                Text(title).font(.headline)
                                Text("ESSAY · 8 MIN READ").font(.caption2.weight(.medium)).foregroundStyle(.secondary)
                            }.padding(.vertical, 12)
                        }
                    }
                }
            }
            .navigationTitle("Reading")
            .toolbarBackground(colored ? Color.indigo : Color.clear, for: .navigationBar)
            .toolbarBackground(colored ? .visible : .automatic, for: .navigationBar)
            .toolbarColorScheme(colored && darkBar ? .dark : nil, for: .navigationBar)
            .toolbar(hidden ? .hidden : .visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Bookmark", systemImage: "bookmark") { colored.toggle() }
                }
            }
        }
        .tint(warmAccent ? .orange : .blue)
        .accessibilityIdentifier("capture-ready")
    }
}

#Preview { NavigationBarAppearanceDemo() }

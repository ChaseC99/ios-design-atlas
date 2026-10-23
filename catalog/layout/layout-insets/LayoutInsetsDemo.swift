import SwiftUI

struct LayoutInsetsDemo: View {
    @State private var margin = 24.0
    @State private var showsBar = true
    @State private var saved = false
    private let notes = ["Morning light", "The coastal path", "A quiet harbor", "Cypress grove", "The long way home"]
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                VStack(spacing: 16) {
                    Slider(value: $margin, in: 0...40, step: 8) { Text("Content margin") }
                    Toggle("Persistent save action", isOn: $showsBar)
                }.padding(.vertical, 12)
                ForEach(Array(notes.enumerated()), id: \.offset) { index, note in
                    HStack(spacing: 20) {
                        Image(systemName: "leaf.fill").foregroundStyle(.green).font(.title2)
                        VStack(alignment: .leading, spacing: 6) {
                            Text(note).font(.headline)
                            Text("Field note \(index + 1)").font(.subheadline).foregroundStyle(.secondary)
                        }
                        Spacer()
                    }
                    .padding(24).frame(maxWidth: .infinity, alignment: .leading)
                    .background(.background, in: RoundedRectangle(cornerRadius: 20))
                }
            }.padding(.vertical, 16)
        }
        .contentMargins(.horizontal, margin, for: .scrollContent)
        .background(Color(uiColor: .secondarySystemBackground).ignoresSafeArea())
        .safeAreaInset(edge: .bottom, spacing: 0) {
            if showsBar {
                HStack {
                    Text("5 field notes").font(.headline)
                    Spacer()
                    Button(saved ? "Saved" : "Save collection") { saved.toggle() }
                        .buttonStyle(.borderedProminent)
                }.padding(20).background(.regularMaterial)
            }
        }
        .navigationTitle("Padding, margins, and safe areas")
        .navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }

}

#Preview { NavigationStack { LayoutInsetsDemo() } }

import SwiftUI

struct NavigationTitleStylesDemo: View {
    private let isCapturing = ProcessInfo.processInfo.arguments.contains("--capture")
    @State private var inline = false
    @State private var longTitle = false
    @State private var customTitle = false
    var body: some View {
        NavigationStack {
            List {
                if !isCapturing {
                    Section("Title") {
                        Toggle("Inline title", isOn: $inline)
                        Toggle("Long title", isOn: $longTitle)
                        Toggle("Custom two-line inline title", isOn: $customTitle)
                    }
                }
                Section("This week") {
                    ForEach(1...24, id: \.self) { index in
                        HStack(spacing: 14) {
                            Image(systemName: "leaf").foregroundStyle(.green)
                                .frame(width: 36, height: 36).background(.green.opacity(0.1), in: .rect(cornerRadius: 10))
                            VStack(alignment: .leading, spacing: 4) {
                                Text(["Morning in the garden", "A quieter afternoon", "The long way home"][(index - 1) % 3])
                                Text("Entry \(index) · Personal journal").font(.caption).foregroundStyle(.secondary)
                            }
                        }.padding(.vertical, 5)
                    }
                }
            }
            .navigationTitle(longTitle ? "Notes from the places we call home" : "Journal")
            .navigationBarTitleDisplayMode(inline || customTitle ? .inline : .large)
            .toolbar {
                if customTitle {
                    ToolbarItem(placement: .principal) {
                        VStack(spacing: 1) {
                            Text("A longer journal title").font(.headline)
                            Text("A custom title can wrap").font(.caption).foregroundStyle(.secondary)
                        }.lineLimit(2)
                    }
                }
            }
        }
        .accessibilityIdentifier("capture-ready")
    }
}

#Preview { NavigationTitleStylesDemo() }

import SwiftUI

struct SheetAppearanceDemo: View {
    private let isCapturing = ProcessInfo.processInfo.arguments.contains("--capture")
    @State private var isPresented = false
    @State private var surface = "Material"
    @State private var indicator = "Visible"
    @State private var customRadius = true
    @State private var radius = 32.0

    private var indicatorVisibility: Visibility {
        switch indicator {
        case "Visible": .visible
        case "Hidden": .hidden
        default: .automatic
        }
    }

    var body: some View {
        Group {
            if isCapturing {
                Color(uiColor: .systemBackground).ignoresSafeArea()
            } else {
                Form {
                    Picker("Background", selection: $surface) {
                        ForEach(["System", "Material", "Color", "Gradient"], id: \.self) { Text($0) }
                    }
                    Picker("Drag indicator", selection: $indicator) {
                        ForEach(["Automatic", "Visible", "Hidden"], id: \.self) { Text($0) }
                    }
                    Toggle("Custom corner radius", isOn: $customRadius)
                    Slider(value: $radius, in: 0...60, step: 4) { Text("Corner radius") }
                        .disabled(!customRadius)
                    Button("Show collection") { isPresented = true }
                        .accessibilityIdentifier("present")
                }
            }
        }
        .navigationTitle("Sheet appearance")
        .sheet(isPresented: $isPresented) {
            styledContent
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(indicatorVisibility)
                .presentationCornerRadius(customRadius ? radius : nil)
                .accessibilityIdentifier("capture-ready")
        }
        .task { if isCapturing { isPresented = true } }
    }

    @ViewBuilder private var styledContent: some View {
        switch surface {
        case "Material": content.presentationBackground(.thinMaterial)
        case "Color": content.presentationBackground(Color.mint.opacity(0.18))
        case "Gradient": content.presentationBackground {
            LinearGradient(colors: [Color.mint.opacity(0.25), Color(uiColor: .systemBackground)],
                           startPoint: .topLeading, endPoint: .bottomTrailing)
        }
        default: content
        }
    }

    private var content: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Image(systemName: "leaf.fill")
                    .font(.system(size: 44)).foregroundStyle(.green)
                Text("A little closer to nature").font(.largeTitle.bold())
                Text("A collection of quiet places, open trails, and afternoons outside.")
                    .foregroundStyle(.secondary)
                Label("12 saved places", systemImage: "bookmark")
                Button("Done") { isPresented = false }
                    .buttonStyle(.borderedProminent)
            }.padding(32).frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview { NavigationStack { SheetAppearanceDemo() } }

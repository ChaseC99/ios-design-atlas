import SwiftUI

struct SheetBackgroundInteractionDemo: View {
    private let isCapturing = ProcessInfo.processInfo.arguments.contains("--capture")
    @State private var isPresented = false
    @State private var savedCount = 3
    @State private var mode = "When collapsed"

    private var interaction: PresentationBackgroundInteraction {
        switch mode {
        case "Always": .enabled
        case "Never": .disabled
        default: .enabled(upThrough: .height(240))
        }
    }

    var body: some View {
        Group {
            if isCapturing {
                Color(uiColor: .systemBackground).ignoresSafeArea()
            } else {
                ScrollView {
                    VStack(spacing: 24) {
                        Image(systemName: "sun.horizon.fill")
                            .font(.system(size: 72)).foregroundStyle(.orange)
                        Text("Places for a slow weekend").font(.title.bold())
                        Button("Saved places: \(savedCount)") { savedCount += 1 }
                            .buttonStyle(.borderedProminent)
                            .accessibilityIdentifier("background-action")
                        Picker("Background interaction", selection: $mode) {
                            ForEach(["When collapsed", "Always", "Never"], id: \.self) { Text($0) }
                        }
                        Button("Show nearby places") { isPresented = true }
                            .accessibilityIdentifier("present")
                    }.padding(28)
                }
            }
        }
        .navigationTitle("Background interaction")
        .sheet(isPresented: $isPresented) {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        Text("Nearby places").font(.title2.bold())
                        Spacer()
                        Button("Done") { isPresented = false }
                    }
                    Label("Cypress grove", systemImage: "tree.fill")
                    Label("Harbor coffee", systemImage: "cup.and.saucer.fill")
                    Label("Old lighthouse", systemImage: "sun.max.fill")
                }.padding(28)
            }
            .presentationDetents([.height(240), .large])
            .presentationBackgroundInteraction(interaction)
            .presentationDragIndicator(.visible)
            .accessibilityIdentifier("capture-ready")
        }
        .task { if isCapturing { isPresented = true } }
    }
}

#Preview { NavigationStack { SheetBackgroundInteractionDemo() } }

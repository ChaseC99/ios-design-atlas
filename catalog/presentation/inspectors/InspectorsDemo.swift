import SwiftUI

struct InspectorsDemo: View {
    private let isCapturing = ProcessInfo.processInfo.arguments.contains("--capture")
    @State private var isPresented = false
    @State private var title = "Morning light"
    @State private var favorite = false
    @State private var rating = 3

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                RoundedRectangle(cornerRadius: 24)
                    .fill(.orange.gradient)
                    .aspectRatio(4.0 / 3.0, contentMode: .fit)
                    .overlay { Image(systemName: "sun.max.fill").font(.system(size: 72)).foregroundStyle(.white) }
                    .accessibilityLabel("Illustrated sun on an orange background")
                Text(title).font(.largeTitle.bold())
                if !isCapturing {
                    Text("An inspector keeps attributes near the selected content. Change the title or mark this reference as a favorite.")
                        .foregroundStyle(.secondary)
                    Label(favorite ? "Favorite" : "Not a favorite", systemImage: favorite ? "star.fill" : "star")
                    Button("Show inspector", systemImage: "sidebar.trailing") { isPresented = true }
                        .buttonStyle(.borderedProminent)
                        .accessibilityIdentifier("present")
                }
            }
            .padding(24)
            .frame(maxWidth: 680)
            .frame(maxWidth: .infinity)
        }
        .background(Color(uiColor: .systemBackground))
        .navigationTitle("Inspectors")
        .navigationBarTitleDisplayMode(.inline)
        .inspector(isPresented: $isPresented) {
            Form {
                Section("Reference details") {
                    TextField("Title", text: $title)
                    Toggle("Favorite", isOn: $favorite)
                    Stepper("Rating: \(rating)", value: $rating, in: 1...5)
                }
                Section {
                    Button("Done") { isPresented = false }
                }
                if !isCapturing {
                    Section {
                        Text("On a wide layout this can be a trailing column. In compact width it adapts to a sheet.")
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .inspectorColumnWidth(min: 280, ideal: 320, max: 400)
            .presentationDetents([.medium, .large])
            .presentationDragIndicator(.visible)
            .accessibilityIdentifier("capture-ready")
        }
        .task { if isCapturing { isPresented = true } }
    }
}

#Preview { NavigationStack { InspectorsDemo() } }

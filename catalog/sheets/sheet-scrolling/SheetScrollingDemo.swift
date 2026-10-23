import SwiftUI

struct SheetScrollingDemo: View {
    private let isCapturing = ProcessInfo.processInfo.arguments.contains("--capture")
    @State private var isPresented = false
    @State private var scrollsFirst = true
    private let places = ["Coastal path", "Cypress grove", "Lighthouse trail", "Harbor steps", "Fern canyon", "Meadow loop", "Redwood ridge", "River bend", "Sunset beach", "Garden walk", "Orchard lane", "Hilltop lookout", "Lake shore", "Dune crossing", "Creekside path", "Wildflower field"]

    var body: some View {
        Group {
            if isCapturing {
                Color(uiColor: .systemBackground).ignoresSafeArea()
            } else {
                Form {
                    Toggle("Scroll before resizing", isOn: $scrollsFirst)
                    Button("Show weekend walks") { isPresented = true }
                        .accessibilityIdentifier("present")
                }
            }
        }
        .navigationTitle("Scrolling and resizing")
        .sheet(isPresented: $isPresented) {
            NavigationStack {
                List(Array(places.enumerated()), id: \.offset) { index, place in
                    HStack(spacing: 16) {
                        Image(systemName: "leaf.fill").foregroundStyle(.green)
                        VStack(alignment: .leading, spacing: 5) {
                            Text(place).font(.headline)
                            Text("\(index % 5 + 2) km · Easy pace")
                                .font(.subheadline).foregroundStyle(.secondary)
                        }
                    }.padding(.vertical, 8)
                }
                .navigationTitle("Weekend walks")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar { Button("Done") { isPresented = false } }
            }
            .presentationDetents([.medium, .large])
            .presentationContentInteraction(scrollsFirst ? .scrolls : .resizes)
            .presentationDragIndicator(.visible)
            .accessibilityIdentifier("capture-ready")
        }
        .task { if isCapturing { isPresented = true } }
    }
}

#Preview { NavigationStack { SheetScrollingDemo() } }

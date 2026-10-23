import SwiftUI

struct ResizeStatePreservationDemo: View {
    var body: some View {
        GeometryReader { proxy in
            let layout = proxy.size.width > 680 ? AnyLayout(HStackLayout(alignment: .top, spacing: 24)) : AnyLayout(VStackLayout(spacing: 24))
            ScrollView {
                layout {
                    ResizeCounterCard()
                    ResizeDraftCard()
                }.padding(24).frame(maxWidth: 1100).frame(maxWidth: .infinity)
            }
        }
        .navigationTitle("A layout that remembers").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
}
private struct ResizeCounterCard: View {
    @State private var count = 3
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("Collected moments").font(.headline)
            Text("\(count)").font(.system(size: 72, weight: .light, design: .rounded)).monospacedDigit().foregroundStyle(.teal)
            Button("Keep another moment", systemImage: "plus") { count += 1 }.buttonStyle(.bordered)
        }.padding(28).frame(maxWidth: .infinity, alignment: .leading)
            .background(.teal.opacity(0.07), in: RoundedRectangle(cornerRadius: 28))
    }
}
private struct ResizeDraftCard: View {
    @State private var draft = "The light was different today."
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("A note for later").font(.headline)
            TextField("Your observation", text: $draft, axis: .vertical).lineLimit(4...8).font(.title3)
            Label("Stays with this view", systemImage: "bookmark").font(.caption).foregroundStyle(.secondary)
        }.padding(28).frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(uiColor: .secondarySystemBackground), in: RoundedRectangle(cornerRadius: 28))
    }
}
#Preview { NavigationStack { ResizeStatePreservationDemo() } }

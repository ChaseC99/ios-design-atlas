import SwiftUI

struct ScrollPositionDemo: View {
    @State private var position = ScrollPosition(idType: Int.self)
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(1...30, id: \.self) { number in
                    HStack(alignment: .top, spacing: 20) {
                        Text(String(format: "%02d", number)).font(.system(.title, design: .serif)).foregroundStyle(.teal).frame(width: 48)
                        VStack(alignment: .leading, spacing: 8) {
                            Text(["Look a little longer", "Take a different route", "Make room for quiet"][(number - 1) % 3]).font(.headline)
                            Text("A small invitation to pay attention.").font(.subheadline).foregroundStyle(.secondary)
                        }
                        Spacer(minLength: 0)
                    }.padding(24).background(Color.teal.opacity(0.06), in: RoundedRectangle(cornerRadius: 24)).id(number)
                }
            }.scrollTargetLayout().padding(24)
        }
        .scrollPosition($position)
        .defaultScrollAnchor(.top, for: .initialOffset)
        .navigationTitle("Thirty moments").navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                Button("Top", systemImage: "arrow.up.to.line") { withAnimation { position.scrollTo(edge: .top) } }
                Spacer()
                Button("15") { withAnimation { position.scrollTo(id: 15, anchor: .center) } }
                Spacer()
                Button("Bottom", systemImage: "arrow.down.to.line") { withAnimation { position.scrollTo(edge: .bottom) } }
            }
        }
        .accessibilityIdentifier("capture-ready")
    }
}
#Preview { NavigationStack { ScrollPositionDemo() } }

import SwiftUI

struct ExpandableSelectableTextDemo: View {
    @State private var expanded = false
    private let passage = "Some mornings ask for nothing more than an open window and a cup of something warm. The light finds its way across the room. The street begins to wake. There is no need to hurry.\n\nTake the familiar path and notice one unfamiliar thing: a new leaf, a painted door, the pattern of shadows on a wall. Small details can make an ordinary day feel a little larger.\n\nKeep a few words about it. They do not have to be important. They only have to help you remember."
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Image(systemName: "sun.horizon").font(.system(size: 64, weight: .ultraLight)).foregroundStyle(.orange).padding(.vertical, 24)
                Text("An ordinary\nkind of lovely.").font(.system(.largeTitle, design: .serif))
                Text(passage).font(.body).lineSpacing(6)
                    .lineLimit(expanded ? nil : 5).textSelection(.enabled)
                Button(expanded ? "Read less" : "Read more") { withAnimation { expanded.toggle() } }
                    .font(.headline).tint(.teal)
                    .accessibilityValue(expanded ? "Expanded" : "Collapsed")
                Divider()
                Text("“Attention is a kind of kindness.”").font(.system(.title3, design: .serif)).italic()
                    .textSelection(.enabled)
                Text("Select any passage to copy it.").font(.caption).foregroundStyle(.secondary)
            }.padding(28).frame(maxWidth: 620)
        }
        .navigationTitle("Reading notes").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
}
#Preview { NavigationStack { ExpandableSelectableTextDemo() } }

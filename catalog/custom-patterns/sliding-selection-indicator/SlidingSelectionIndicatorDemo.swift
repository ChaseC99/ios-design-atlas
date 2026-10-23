import SwiftUI

// Concept inspiration: Sarun Wongpatcharapakorn, “A first look at matchedGeometryEffect” (2020-07-01).
// https://sarunw.com/posts/a-first-look-at-matchedgeometryeffect/
// Original catalog implementation; this is not a reproduction of the article's sample.
struct SlidingSelectionIndicatorDemo: View {
    @Namespace private var selection
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var period = "Morning"
    private let periods = ["Morning", "Afternoon", "Evening"]
    private var title: String { period == "Morning" ? "Start with a little quiet." : period == "Afternoon" ? "Make room for a detour." : "Let the day slow down." }
    private var symbol: String { period == "Morning" ? "sun.horizon" : period == "Afternoon" ? "sun.max" : "moon.stars" }
    var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            Text("Find your rhythm.").font(.system(.largeTitle, design: .serif))
            HStack(spacing: 4) {
                ForEach(periods, id: \.self) { item in
                    Button {
                        withAnimation(reduceMotion ? nil : .spring(response: 0.35, dampingFraction: 0.8)) { period = item }
                    } label: {
                        Text(item).font(.subheadline.weight(.semibold)).lineLimit(1).minimumScaleFactor(0.8)
                            .frame(maxWidth: .infinity).padding(.vertical, 16)
                            .foregroundStyle(period == item ? .white : .primary)
                            .background {
                                if period == item { Capsule().fill(.teal).matchedGeometryEffect(id: "selection", in: selection) }
                            }
                            .contentShape(Capsule())
                    }.buttonStyle(.plain).accessibilityAddTraits(period == item ? .isSelected : [])
                }
            }.padding(5).background(.teal.opacity(0.08), in: Capsule())
            VStack(alignment: .leading, spacing: 28) {
                Image(systemName: symbol).font(.system(size: 78, weight: .ultraLight)).foregroundStyle(.teal)
                    .contentTransition(.symbolEffect(.replace))
                Text(title).font(.system(.title, design: .serif)).fixedSize(horizontal: false, vertical: true)
                Text(period == "Morning" ? "A warm cup. An open window. A page waiting to be filled." : period == "Afternoon" ? "Walk down an unfamiliar street and see where it takes you." : "Put on a favorite record and leave tomorrow for tomorrow.")
                    .foregroundStyle(.secondary).lineSpacing(5)
            }.padding(28).frame(maxWidth: .infinity, minHeight: 340, alignment: .topLeading)
                .background(Color(uiColor: .secondarySystemBackground), in: .rect(cornerRadius: 30))
            Spacer()
        }.padding(24).frame(maxWidth: 700).frame(maxWidth: .infinity)
        .navigationTitle("Daily rhythm").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
}
#Preview { NavigationStack { SlidingSelectionIndicatorDemo() } }

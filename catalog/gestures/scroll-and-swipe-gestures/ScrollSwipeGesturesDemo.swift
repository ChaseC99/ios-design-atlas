import SwiftUI

struct ScrollSwipeGesturesDemo: View {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var open = false
    @State private var favorite = false
    @State private var priority = "Simultaneous"
    @GestureState private var translation = 0.0
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Reading list").font(.largeTitle.bold())
                    Text("Saved for a slower afternoon.").foregroundStyle(.secondary)
                }
                ZStack(alignment: .trailing) {
                    Button {
                        favorite.toggle()
                        setOpen(false)
                    } label: {
                        VStack(spacing: 8) {
                            Image(systemName: favorite ? "heart.slash" : "heart.fill").font(.title2)
                            Text(favorite ? "Unsave" : "Favorite").font(.caption)
                        }.frame(width: 96, height: 124).foregroundStyle(.white)
                    }.buttonStyle(.plain)
                    swipeCard
                }
                .frame(height: 124)
                .background(.pink.gradient, in: .rect(cornerRadius: 20))
                .clipShape(.rect(cornerRadius: 20))
                Picker("Gesture attachment", selection: $priority) {
                    Text("Simultaneous").tag("Simultaneous")
                    Text("High priority").tag("High priority")
                }.pickerStyle(.segmented)
                Button(open ? "Hide action" : "Reveal action") { setOpen(!open) }
                ForEach(1...7, id: \.self) { index in
                    HStack(spacing: 16) {
                        Image(systemName: "book.closed").font(.title2).foregroundStyle(.secondary)
                        VStack(alignment: .leading, spacing: 4) {
                            Text(["The long way home", "A place to begin", "The art of noticing", "Northern light", "Field notes", "Ocean air", "Small discoveries"][index - 1]).font(.headline)
                            Text("Essay · \(index + 3) min read").font(.subheadline).foregroundStyle(.secondary)
                        }
                        Spacer()
                    }.padding().background(.quaternary.opacity(0.5), in: .rect(cornerRadius: 16))
                }
            }.padding(20)
        }
        .navigationTitle("Scroll and swipe").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
        .task { if ProcessInfo.processInfo.arguments.contains("--capture") { open = true } }
    }
    private var drag: some Gesture {
        DragGesture(minimumDistance: 15)
            .updating($translation) { value, state, _ in
                if abs(value.translation.width) > abs(value.translation.height) { state = value.translation.width }
            }
            .onEnded { value in
                guard abs(value.translation.width) > abs(value.translation.height) else { return }
                setOpen((open ? -96 : 0) + value.translation.width < -48)
            }
    }
    @ViewBuilder private var swipeCard: some View {
        if priority == "High priority" { card.highPriorityGesture(drag) }
        else { card.simultaneousGesture(drag) }
    }
    private var card: some View {
        HStack(spacing: 16) {
            Image(systemName: "sun.horizon.fill").font(.largeTitle).foregroundStyle(.orange)
            VStack(alignment: .leading, spacing: 6) {
                Text("A wider horizon").font(.headline)
                Text(favorite ? "In your favorites" : "Essay · 8 min read").foregroundStyle(.secondary).font(.subheadline)
            }
            Spacer()
        }
        .padding(20).frame(maxWidth: .infinity, minHeight: 124)
        .background(Color(.secondarySystemBackground))
        .contentShape(.rect)
        .offset(x: min(0, max(-96, (open ? -96 : 0) + translation)))
        .accessibilityElement(children: .combine)
        .accessibilityAction(named: "Toggle favorite") { favorite.toggle() }
        .accessibilityAction(named: "Toggle reveal") { setOpen(!open) }
    }
    private func setOpen(_ value: Bool) {
        withAnimation(reduceMotion ? nil : .snappy(duration: 0.25)) { open = value }
    }
}

#Preview { NavigationStack { ScrollSwipeGesturesDemo() } }

import SwiftUI

struct ReorderableGridDemo: View {
    @State private var order = Array(0..<9)
    @State private var targeted: Int?
    private let titles = ["First light", "Open water", "After dark", "Higher ground", "Slow days", "Passing clouds", "Small wonders", "Far from here", "Home again"]
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 105), spacing: 14)], spacing: 20) {
                ForEach(order, id: \.self) { id in
                    VStack(spacing: 10) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20).fill([Color.orange, .teal, .indigo, .brown, .green, .blue, .pink, .purple, .cyan][id].gradient)
                            Image(systemName: ["sun.horizon", "water.waves", "moon.stars", "mountain.2", "leaf", "cloud.sun", "sparkles", "airplane", "house"][id])
                                .font(.system(size: 34)).foregroundStyle(.white)
                        }.aspectRatio(1, contentMode: .fit)
                            .overlay { RoundedRectangle(cornerRadius: 20).stroke(targeted == id ? Color.primary : .clear, lineWidth: 3) }
                        Text(titles[id]).font(.caption.weight(.medium)).lineLimit(2).multilineTextAlignment(.center)
                    }
                    .draggable("atlas-grid-\(id)")
                    .dropDestination(for: String.self) { payload, _ in
                        guard let value = payload.first, value.hasPrefix("atlas-grid-"), let moved = Int(value.dropFirst(11)) else { return false }
                        return move(moved, to: id)
                    } isTargeted: { active in targeted = active ? id : (targeted == id ? nil : targeted) }
                    .accessibilityElement(children: .ignore)
                    .accessibilityLabel(titles[id])
                    .accessibilityValue("Position \((order.firstIndex(of: id) ?? 0) + 1) of \(order.count)")
                    .accessibilityAction(named: "Move earlier") {
                        if let index = order.firstIndex(of: id), index > 0 { withAnimation { order.swapAt(index, index - 1) } }
                    }
                    .accessibilityAction(named: "Move later") {
                        if let index = order.firstIndex(of: id), index < order.count - 1 { withAnimation { order.swapAt(index, index + 1) } }
                    }
                }
            }.padding(20)
        }
        .navigationTitle("Arrange artwork")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar { ToolbarItem(placement: .topBarTrailing) { Button("Reset") { withAnimation { order = Array(0..<9) } } } }
        .accessibilityIdentifier("capture-ready")
    }
    @discardableResult private func move(_ moved: Int, to target: Int) -> Bool {
        guard moved != target, let source = order.firstIndex(of: moved), let destination = order.firstIndex(of: target) else { return false }
        withAnimation(.snappy) { order.move(fromOffsets: IndexSet(integer: source), toOffset: source < destination ? destination + 1 : destination) }
        targeted = nil
        return true
    }
}

#Preview { NavigationStack { ReorderableGridDemo() } }

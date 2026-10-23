import SwiftUI

struct DragBetweenCollectionsDemo: View {
    @State private var ideas = ["Reading nook", "Window garden", "Weekend cabin"]
    @State private var planned = ["Morning walk"]
    @State private var overIdeas = false
    @State private var overPlanned = false
    var body: some View {
        GeometryReader { proxy in
            let layout = proxy.size.width > 700 ? AnyLayout(HStackLayout(alignment: .top, spacing: 24)) : AnyLayout(VStackLayout(spacing: 24))
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text("Room for ideas").font(.system(.largeTitle, design: .serif))
                    layout {
                        board("Someday", items: ideas, tint: .indigo, targeted: overIdeas, destination: false)
                            .dropDestination(for: String.self) { values, _ in move(values, toPlanned: false) } isTargeted: { overIdeas = $0 }
                        board("This week", items: planned, tint: .teal, targeted: overPlanned, destination: true)
                            .dropDestination(for: String.self) { values, _ in move(values, toPlanned: true) } isTargeted: { overPlanned = $0 }
                    }
                }.padding(24).frame(maxWidth: 1100).frame(maxWidth: .infinity)
            }
        }
        .navigationTitle("Idea boards").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
    private func board(_ title: String, items: [String], tint: Color, targeted: Bool, destination: Bool) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack { Text(title).font(.title2.weight(.semibold)); Spacer(); Text("\(items.count)").foregroundStyle(.secondary) }
            ForEach(items, id: \.self) { item in
                Label(item, systemImage: "sparkle")
                    .frame(maxWidth: .infinity, alignment: .leading).padding(18)
                    .background(.background, in: .rect(cornerRadius: 16))
                    .draggable(item)
                    .contextMenu {
                        Button(destination ? "Move to Someday" : "Move to This week", systemImage: "arrow.left.arrow.right") { _ = move([item], toPlanned: !destination) }
                    }
                    .accessibilityAction(named: destination ? "Move to Someday" : "Move to This week") { _ = move([item], toPlanned: !destination) }
            }
            if items.isEmpty {
                Label("Drop an idea here", systemImage: "tray").foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, minHeight: 80)
            }
        }
        .padding(20).frame(maxWidth: .infinity, alignment: .topLeading)
        .background(tint.opacity(targeted ? 0.22 : 0.09), in: .rect(cornerRadius: 24))
        .overlay(RoundedRectangle(cornerRadius: 24).stroke(tint.opacity(targeted ? 0.8 : 0.15), lineWidth: 2))
    }
    private func move(_ values: [String], toPlanned: Bool) -> Bool {
        let source = toPlanned ? ideas : planned
        let accepted = values.filter { source.contains($0) }
        guard !accepted.isEmpty else { return false }
        if toPlanned {
            ideas.removeAll { accepted.contains($0) }
            for value in accepted where !planned.contains(value) { planned.append(value) }
        } else {
            planned.removeAll { accepted.contains($0) }
            for value in accepted where !ideas.contains(value) { ideas.append(value) }
        }
        return true
    }
}
#Preview { NavigationStack { DragBetweenCollectionsDemo() } }

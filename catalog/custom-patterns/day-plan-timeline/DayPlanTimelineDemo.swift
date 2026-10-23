import SwiftUI

struct DayPlanTimelineDemo: View {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var selected = 1
    @State private var completed: Set<Int> = [0]
    private let events = [Event(id: 0, time: "09:00", title: "Coffee and a notebook", subtitle: "Start slowly", symbol: "cup.and.saucer", detail: "A warm drink and a page for whatever comes to mind."), Event(id: 1, time: "10:30", title: "The garden path", subtitle: "A little fresh air", symbol: "leaf", detail: "Take the winding path through the trees. Leave time to stop along the way."), Event(id: 2, time: "12:00", title: "Lunch by the water", subtitle: "Stay awhile", symbol: "fork.knife", detail: "Find a quiet table and make room for a long conversation."), Event(id: 3, time: "14:30", title: "A bookshop detour", subtitle: "Something unexpected", symbol: "books.vertical", detail: "Choose a book by its first page. Walk home the long way.")]
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 28) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("A Saturday outside.").font(.system(.largeTitle, design: .serif))
                    Text("Four stops. No need to hurry.").foregroundStyle(.secondary)
                }
                VStack(spacing: 0) {
                    ForEach(events) { event in
                        HStack(alignment: .top, spacing: 16) {
                            Text(event.time).font(.caption.monospacedDigit()).foregroundStyle(.secondary).frame(width: 44).padding(.top, 6)
                            VStack(spacing: 0) {
                                Image(systemName: completed.contains(event.id) ? "checkmark.circle.fill" : "circle.fill")
                                    .font(.system(size: 18)).foregroundStyle(selected == event.id ? .orange : .teal)
                                    .frame(width: 22, height: 28)
                                Rectangle().fill(.teal.opacity(0.2)).frame(width: 2).frame(maxHeight: .infinity)
                                    .opacity(event.id == events.last?.id ? 0 : 1)
                            }.accessibilityHidden(true)
                            VStack(alignment: .leading, spacing: 14) {
                                Button {
                                    withAnimation(reduceMotion ? nil : .snappy) { selected = event.id }
                                } label: {
                                    VStack(alignment: .leading, spacing: 7) {
                                        Label(event.title, systemImage: event.symbol).font(.headline)
                                        Text(event.subtitle).font(.subheadline).foregroundStyle(.secondary)
                                    }.frame(maxWidth: .infinity, alignment: .leading).contentShape(Rectangle())
                                }.buttonStyle(.plain).accessibilityAddTraits(selected == event.id ? .isSelected : [])
                                if selected == event.id {
                                    Text(event.detail).font(.subheadline).foregroundStyle(.secondary)
                                    Button(completed.contains(event.id) ? "Mark incomplete" : "Mark complete", systemImage: completed.contains(event.id) ? "arrow.uturn.backward" : "checkmark") {
                                        if completed.contains(event.id) { completed.remove(event.id) } else { completed.insert(event.id) }
                                    }.buttonStyle(.bordered).font(.caption)
                                }
                            }
                            .padding(18).frame(maxWidth: .infinity, alignment: .leading)
                            .background(selected == event.id ? Color.teal.opacity(0.08) : .clear, in: .rect(cornerRadius: 22))
                            .padding(.bottom, 20)
                        }.fixedSize(horizontal: false, vertical: true)
                    }
                }
            }.padding(24).frame(maxWidth: 760).frame(maxWidth: .infinity)
        }
        .navigationTitle("Day plan").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
    private struct Event: Identifiable { let id: Int; let time: String; let title: String; let subtitle: String; let symbol: String; let detail: String }
}
#Preview { NavigationStack { DayPlanTimelineDemo() } }

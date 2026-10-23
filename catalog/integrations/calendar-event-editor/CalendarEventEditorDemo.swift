import SwiftUI
import EventKitUI

struct CalendarEventEditorDemo: View {
    @State private var presented = false
    @State private var status = "Not added to a calendar"
    private let start = Calendar.current.date(from: DateComponents(year: 2026, month: 10, day: 24, hour: 9))!
    var body: some View {
        Form {
            Section {
                VStack(alignment: .leading, spacing: 20) {
                    Image(systemName: "calendar.badge.plus").font(.system(size: 54)).foregroundStyle(.teal)
                    Text("Harbor walk").font(.largeTitle.bold())
                    Text("A slow morning by the water.").foregroundStyle(.secondary)
                }.padding(.vertical, 24)
                LabeledContent("Date", value: start.formatted(date: .abbreviated, time: .omitted))
                LabeledContent("Time", value: "9:00–10:00 AM")
                LabeledContent("Location", value: "Harbor promenade")
            }
            Section {
                Button("Review in Calendar", systemImage: "calendar") { presented = true }.buttonStyle(.borderedProminent)
                Text(status).font(.subheadline).foregroundStyle(.secondary)
            }
        }
        .sheet(isPresented: $presented) {
            AtlasCalendarEditor(start: start) { action in
                switch action {
                case .saved: status = "Event saved by Calendar"
                case .canceled: status = "Calendar editing cancelled"
                case .deleted: status = "Event deleted in Calendar"
                @unknown default: status = "Calendar editor closed"
                }
                presented = false
            }
        }
        .navigationTitle("Calendar event editing").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
}
private struct AtlasCalendarEditor: UIViewControllerRepresentable {
    let start: Date
    var completed: (EKEventEditViewAction) -> Void
    func makeCoordinator() -> Coordinator { Coordinator(completed) }
    func makeUIViewController(context: Context) -> EKEventEditViewController {
        let store = EKEventStore()
        let event = EKEvent(eventStore: store)
        event.title = "Harbor walk"
        event.location = "Harbor promenade"
        event.notes = "Local iOS Design Atlas sample."
        event.startDate = start; event.endDate = start.addingTimeInterval(3600)
        let controller = EKEventEditViewController()
        controller.eventStore = store; controller.event = event; controller.editViewDelegate = context.coordinator
        return controller
    }
    func updateUIViewController(_ controller: EKEventEditViewController, context: Context) {}
    final class Coordinator: NSObject, EKEventEditViewDelegate {
        let completed: (EKEventEditViewAction) -> Void
        init(_ completed: @escaping (EKEventEditViewAction) -> Void) { self.completed = completed }
        func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) { completed(action) }
    }
}

#Preview { NavigationStack { CalendarEventEditorDemo() } }

import SwiftUI

struct DateSelectionDemo: View {
    @State private var mode = "Separate days"
    @State private var start = Calendar.current.date(from: DateComponents(year: 2026, month: 10, day: 24))!
    @State private var end = Calendar.current.date(from: DateComponents(year: 2026, month: 10, day: 26))!
    @State private var dates: Set<DateComponents> = [
        DateComponents(year: 2026, month: 10, day: 24),
        DateComponents(year: 2026, month: 10, day: 25)
    ]
    var body: some View {
        Form {
            Section {
                Picker("Selection", selection: $mode) {
                    Text("Separate days").tag("Separate days")
                    Text("Date range").tag("Date range")
                }.pickerStyle(.segmented)
            }
            if mode == "Separate days" {
                Section("Days outside") {
                    MultiDatePicker("Choose available days", selection: $dates)
                    Text("\(dates.count) days selected").foregroundStyle(.secondary)
                    Button("Clear selection") { dates.removeAll() }.disabled(dates.isEmpty)
                }
            } else {
                Section("A weekend away") {
                    DatePicker("Arrival", selection: $start, displayedComponents: .date)
                    DatePicker("Departure", selection: $end, in: start..., displayedComponents: .date)
                    Text("\(max(0, Calendar.current.dateComponents([.day], from: start, to: end).day ?? 0)) nights")
                        .foregroundStyle(.secondary)
                }
            }
        }
        .onChange(of: start) { _, newStart in if end < newStart { end = newStart } }
        .navigationTitle("Date ranges and multiple dates")
        .navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }

}

#Preview { NavigationStack { DateSelectionDemo() } }

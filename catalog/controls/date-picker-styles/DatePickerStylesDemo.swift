import SwiftUI

struct DatePickerStylesDemo: View {
    @State private var date = Calendar(identifier: .gregorian).date(from: DateComponents(year: 2026, month: 10, day: 24, hour: 9))!
    @State private var style = "Graphical"
    @State private var components = "Date"
    @State private var localeID = "en_US"
    @State private var zoneID = "America/Los_Angeles"
    private var displayed: DatePickerComponents {
        switch components {
        case "Time": .hourAndMinute
        case "Date and time": [.date, .hourAndMinute]
        default: .date
        }
    }
    private var picker: some View {
        DatePicker("Departure", selection: $date, displayedComponents: displayed)
            .environment(\.locale, Locale(identifier: localeID))
            .environment(\.timeZone, TimeZone(identifier: zoneID)!)
    }
    var body: some View {
        Form {
            Section("Departure") {
                switch style {
                case "Compact": picker.datePickerStyle(.compact)
                case "Wheel": picker.datePickerStyle(.wheel)
                default: picker.datePickerStyle(.graphical)
                }
            }
            Section("Presentation") {
                Picker("Style", selection: $style) {
                    ForEach(["Compact", "Wheel", "Graphical"], id: \.self) { Text($0) }
                }
                Picker("Components", selection: $components) {
                    ForEach(style == "Graphical" ? ["Date", "Date and time"] : ["Date", "Time", "Date and time"], id: \.self) { Text($0) }
                }
                Picker("Locale", selection: $localeID) {
                    Text("English (US)").tag("en_US")
                    Text("German").tag("de_DE")
                    Text("Arabic (Saudi Arabia)").tag("ar_SA")
                }
                Picker("Time zone", selection: $zoneID) {
                    Text("Los Angeles").tag("America/Los_Angeles")
                    Text("Paris").tag("Europe/Paris")
                    Text("Tokyo").tag("Asia/Tokyo")
                }
            }
        }
        .onChange(of: style) { _, value in
            if value == "Graphical", components == "Time" { components = "Date" }
        }
        .navigationTitle("Date and time pickers")
        .navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }

}

#Preview { NavigationStack { DatePickerStylesDemo() } }

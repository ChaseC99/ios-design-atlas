import SwiftUI

struct LocalizedValueFormatsDemo: View {
    @State private var identifier = "de_DE"
    private let isCapturing = ProcessInfo.processInfo.arguments.contains("--capture")
    private var locale: Locale { Locale(identifier: identifier) }
    private let sampleDate = Date(timeIntervalSince1970: 1760000000)
    var body: some View {
        Form {
            if !isCapturing {
                Picker("Formatting locale", selection: $identifier) {
                    Text("United States").tag("en_US"); Text("United Kingdom").tag("en_GB")
                    Text("Deutschland").tag("de_DE"); Text("مصر").tag("ar_EG"); Text("日本").tag("ja_JP")
                }
            }
            Section {
                VStack(alignment: .leading, spacing: 8) {
                    Text(locale.localizedString(forIdentifier: identifier) ?? identifier).font(.title2.bold())
                    Text(identifier).font(.caption.monospaced()).foregroundStyle(.secondary)
                }.padding(.vertical, 8)
            }
            Section("Same values, local conventions") {
                formatRow("Number", value: 1234567.89.formatted(.number.precision(.fractionLength(2)).locale(locale)))
                formatRow("Currency · USD", value: 1234.50.formatted(.currency(code: "USD").locale(locale)))
                formatRow("Percentage", value: 0.425.formatted(.percent.precision(.fractionLength(1)).locale(locale)))
                formatRow("Date · UTC", value: sampleDate.formatted(Date.FormatStyle(date: .long, time: .shortened, locale: locale, timeZone: TimeZone(secondsFromGMT: 0)!)))
                formatRow("Distance", value: Measurement(value: 1200, unit: UnitLength.meters).formatted(.measurement(width: .wide, usage: .road).locale(locale)))
            }
        }
        .navigationTitle("Local conventions").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
    private func formatRow(_ label: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(label).font(.caption).foregroundStyle(.secondary)
            Text(value).font(.title3).textSelection(.enabled)
        }.padding(.vertical, 10)
    }
}

#Preview { NavigationStack { LocalizedValueFormatsDemo() } }

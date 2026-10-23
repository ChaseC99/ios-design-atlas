import SwiftUI

struct MixedDirectionContentDemo: View {
    @State private var isolate = true
    private let isCapturing = ProcessInfo.processInfo.arguments.contains("--capture")
    private func isolated(_ text: String) -> String { isolate ? "\u{2068}\(text)\u{2069}" : text }
    var body: some View {
        List {
            Section {
                VStack(alignment: .leading, spacing: 16) {
                    Text("لنبقَ على تواصل").font(.largeTitle.bold())
                    Text("يمكنك التواصل معنا باستخدام المعلومات التالية.").foregroundStyle(.secondary)
                }.frame(maxWidth: .infinity, alignment: .leading).padding(.vertical, 14)
            }
            Section("معلومات التواصل") {
                Text("البريد الإلكتروني: \(isolated("avery@example.com"))").textSelection(.enabled).padding(.vertical, 10)
                Text("الهاتف: \(isolated("+1 415 555 0123"))").textSelection(.enabled).padding(.vertical, 10)
                Text("الموقع: \(isolated("example.com/atlas"))").textSelection(.enabled).padding(.vertical, 10)
            }
            Section {
                Text("المرجع \(isolated("ATLAS-2026-042")) جاهز للحفظ.").padding(.vertical, 8)
            }
            if !isCapturing { Section { Toggle("Direction isolation", isOn: $isolate) } }
        }
        .navigationTitle("التواصل").navigationBarTitleDisplayMode(.inline)
        .environment(\.locale, Locale(identifier: "ar"))
        .environment(\.layoutDirection, .rightToLeft)
        .accessibilityIdentifier("capture-ready")
    }
}

#Preview { NavigationStack { MixedDirectionContentDemo() } }

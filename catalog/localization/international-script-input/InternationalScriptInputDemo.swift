import SwiftUI

struct InternationalScriptInputDemo: View {
    private struct Sample: Identifiable { let id: String; let locale: String; var text: String; let rtl: Bool }
    @State private var samples = [
        Sample(id: "日本語", locale: "ja", text: "日々のひらめき", rtl: false),
        Sample(id: "العربية", locale: "ar", text: "إلهام كل يوم", rtl: true),
        Sample(id: "हिन्दी", locale: "hi", text: "हर दिन की प्रेरणा", rtl: false),
        Sample(id: "한국어", locale: "ko", text: "일상의 영감", rtl: false),
        Sample(id: "ไทย", locale: "th", text: "แรงบันดาลใจในทุกวัน", rtl: false)
    ]
    var body: some View {
        List {
            ForEach($samples) { $sample in
                Section(sample.id) {
                    TextField("Sample text", text: $sample.text, axis: .vertical)
                        .font(.title3).lineLimit(1...4).textInputAutocapitalization(.never)
                        .environment(\.locale, Locale(identifier: sample.locale))
                        .environment(\.layoutDirection, sample.rtl ? .rightToLeft : .leftToRight)
                        .padding(.vertical, 12)
                }
            }
        }
        .scrollDismissesKeyboard(.interactively)
        .navigationTitle("Everyday inspiration").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
}

#Preview { NavigationStack { InternationalScriptInputDemo() } }

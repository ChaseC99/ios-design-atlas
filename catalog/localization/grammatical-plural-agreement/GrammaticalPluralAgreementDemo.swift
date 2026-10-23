import SwiftUI

struct GrammaticalPluralAgreementDemo: View {
    @State private var count = 3
    private let isCapturing = ProcessInfo.processInfo.arguments.contains("--capture")
    var body: some View {
        List {
            Section {
                VStack(alignment: .leading, spacing: 16) {
                    Image(systemName: "bookmark.fill").font(.system(size: 42)).foregroundStyle(.indigo).accessibilityHidden(true)
                    Text("^[\(count) saved note](inflect: true)").font(.largeTitle.bold())
                    Text("A few things worth keeping close.").foregroundStyle(.secondary)
                }.padding(.vertical, 18)
                if !isCapturing { Stepper("Count: \(count)", value: $count, in: 0...30) }
            }
            Section("Count variations") {
                ForEach([0, 1, 2, 5, 21], id: \.self) { value in
                    Text("^[\(value) saved note](inflect: true)").padding(.vertical, 10)
                }
            }
        }
        .environment(\.locale, Locale(identifier: "en_US"))
        .navigationTitle("Words that agree").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
}

#Preview { NavigationStack { GrammaticalPluralAgreementDemo() } }

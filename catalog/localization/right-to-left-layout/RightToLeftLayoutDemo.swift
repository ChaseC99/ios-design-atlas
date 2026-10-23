import SwiftUI

struct RightToLeftLayoutDemo: View {
    @State private var arabic = true
    private let isCapturing = ProcessInfo.processInfo.arguments.contains("--capture")
    var body: some View {
        NavigationStack {
            List {
                Section {
                    VStack(alignment: .leading, spacing: 14) {
                        Image(systemName: "sun.horizon.fill").font(.system(size: 44)).foregroundStyle(.orange).accessibilityHidden(true)
                        Text(arabic ? "مساحة صغيرة للاكتشاف" : "A little room to explore").font(.largeTitle.bold())
                        Text(arabic ? "أماكن تستحق العودة إليها" : "Places worth returning to").foregroundStyle(.secondary)
                    }.frame(maxWidth: .infinity, alignment: .leading).padding(.vertical, 16)
                }
                Section(arabic ? "المجموعات" : "Collections") {
                    NavigationLink {
                        Text(arabic ? "طريق على الساحل" : "A path by the coast").font(.largeTitle).padding()
                            .navigationTitle(arabic ? "الساحل" : "The coast").navigationBarTitleDisplayMode(.inline)
                    } label: { Label(arabic ? "المشي على الساحل" : "Coastal walks", systemImage: "water.waves").padding(.vertical, 10) }
                    Label(arabic ? "صباح هادئ" : "Quiet mornings", systemImage: "cup.and.saucer").padding(.vertical, 10)
                    Label(arabic ? "أماكن مفضلة" : "Favorite places", systemImage: "star").padding(.vertical, 10)
                }
            }
            .navigationTitle(arabic ? "اكتشف" : "Explore")
            .toolbar {
                if !isCapturing { ToolbarItem(placement: .topBarTrailing) { Button(arabic ? "English" : "العربية") { arabic.toggle() } } }
            }
        }
        .environment(\.layoutDirection, arabic ? .rightToLeft : .leftToRight)
        .environment(\.locale, Locale(identifier: arabic ? "ar" : "en_US"))
        .accessibilityIdentifier("capture-ready")
    }
}

#Preview { RightToLeftLayoutDemo() }

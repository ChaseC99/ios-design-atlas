import SwiftUI

struct FullBleedSafeAreasDemo: View {
    @State private var saved = false
    var body: some View {
        ZStack {
            LinearGradient(colors: [.indigo, .teal, Color(red: 0.65, green: 0.85, blue: 0.75)], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            GeometryReader { geometry in
                Circle().fill(.white.opacity(0.18))
                    .frame(width: geometry.size.width * 1.3)
                    .offset(x: geometry.size.width * 0.3, y: geometry.size.height * 0.1)
            }.ignoresSafeArea().accessibilityHidden(true)
            VStack(alignment: .leading, spacing: 18) {
                Spacer()
                Text("FIELD GUIDE / 04").font(.caption.weight(.semibold)).tracking(3)
                Text("Somewhere\nslower.").font(.system(size: 52, weight: .medium, design: .serif))
                    .minimumScaleFactor(0.65)
                Text("A little further from everything.\nA little closer to yourself.")
                    .font(.title3).lineSpacing(4).opacity(0.85)
                Spacer()
            }.frame(maxWidth: 600, alignment: .leading).frame(maxWidth: .infinity, alignment: .leading).padding(32)
        }
        .foregroundStyle(.white)
        .safeAreaInset(edge: .bottom) {
            Button { saved.toggle() } label: {
                Label(saved ? "Saved" : "Save this place", systemImage: saved ? "checkmark" : "bookmark")
                    .frame(maxWidth: .infinity).padding(.vertical, 12)
            }.buttonStyle(.bordered).tint(.white).padding(.horizontal, 28).padding(.bottom, 12)
        }
        .navigationTitle("Escape").navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.hidden, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .accessibilityIdentifier("capture-ready")
    }
}
#Preview { NavigationStack { FullBleedSafeAreasDemo() } }

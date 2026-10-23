import SwiftUI

struct AccessibleAdjustableControlsDemo: View {
    @State private var rating = 4
    var body: some View {
        VStack(spacing: 28) {
            Image(systemName: "cup.and.saucer.fill").font(.system(size: 72)).foregroundStyle(.brown).accessibilityHidden(true)
            VStack(spacing: 12) {
                Text("A place worth returning to.").font(.system(.largeTitle, design: .serif).weight(.semibold)).multilineTextAlignment(.center)
                Text("How was your visit?").foregroundStyle(.secondary)
            }
            HStack(spacing: 8) {
                ForEach(1...5, id: \.self) { value in
                    Button { rating = value } label: {
                        Image(systemName: value <= rating ? "star.fill" : "star")
                            .font(.system(size: 32)).foregroundStyle(.orange).frame(minWidth: 44, minHeight: 44)
                    }.buttonStyle(.plain)
                }
            }
            .accessibilityElement(children: .ignore)
            .accessibilityLabel("Rating")
            .accessibilityValue("\(rating) of 5 stars")
            .accessibilityAdjustableAction { direction in
                switch direction { case .increment: rating = min(5, rating + 1); case .decrement: rating = max(1, rating - 1); @unknown default: break }
            }
            Text("\(rating) of 5 stars").font(.subheadline).foregroundStyle(.secondary).accessibilityHidden(true)
        }
        .padding(28).frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationTitle("Your review").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
}

#Preview { NavigationStack { AccessibleAdjustableControlsDemo() } }

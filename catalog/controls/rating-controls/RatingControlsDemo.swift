import SwiftUI

struct RatingControlsDemo: View {
    @State private var rating = 3
    @State private var enabled = true
    var body: some View {
        Form {
            Section {
                VStack(spacing: 24) {
                    Image(systemName: "mountain.2.fill").font(.system(size: 72)).foregroundStyle(.teal)
                    Text("The coastal path").font(.title2.bold())
                    Text("How was your walk?").foregroundStyle(.secondary)
                    HStack(spacing: 4) {
                        ForEach(1...5, id: \.self) { value in
                            Button { rating = value } label: {
                                Image(systemName: value <= rating ? "star.fill" : "star")
                                    .font(.title2).frame(minWidth: 44, minHeight: 44)
                            }.buttonStyle(.plain)
                        }
                    }
                    .foregroundStyle(.orange).disabled(!enabled)
                    .opacity(enabled ? 1 : 0.4)
                    .accessibilityElement(children: .ignore)
                    .accessibilityLabel("Walk rating")
                    .accessibilityValue("\(rating) out of 5 stars")
                    .accessibilityAdjustableAction { direction in
                        guard enabled else { return }
                        switch direction {
                        case .increment: rating = min(5, rating + 1)
                        case .decrement: rating = max(0, rating - 1)
                        @unknown default: break
                        }
                    }
                    Text(rating == 0 ? "Not rated" : "\(rating) of 5 stars").font(.subheadline)
                }.frame(maxWidth: .infinity).padding(.vertical, 24)
            }
            Section {
                Toggle("Rating enabled", isOn: $enabled)
                Button("Clear rating") { rating = 0 }.disabled(!enabled || rating == 0)
            }
        }
        .navigationTitle("Rating controls")
        .navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }

}

#Preview { NavigationStack { RatingControlsDemo() } }

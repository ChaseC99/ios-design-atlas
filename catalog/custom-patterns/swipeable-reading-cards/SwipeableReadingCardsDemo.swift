import SwiftUI

struct SwipeableReadingCardsDemo: View {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var index = 0
    @GestureState private var dragOffset: CGFloat = 0
    @State private var exitOffset: CGFloat = 0
    @State private var saved: [String] = []
    @State private var skipped = 0
    @State private var moving = false
    @State private var moveTask: Task<Void, Never>?
    private let titles = ["The long way home", "A room with a view", "Notes from the garden", "An ordinary afternoon"]
    private let subtitles = ["A story about paying attention", "On making space for quiet", "Small things, slowly growing", "The art of doing less"]
    private var offset: CGFloat { moving ? exitOffset : dragOffset }
    var body: some View {
        VStack(spacing: 28) {
            HStack { Text("Your next read").font(.system(.largeTitle, design: .serif)); Spacer() }
            if index < titles.count {
                ZStack {
                    RoundedRectangle(cornerRadius: 32).fill(.teal.opacity(0.1)).rotationEffect(.degrees(4)).padding(12)
                    VStack(alignment: .leading, spacing: 24) {
                        Image(systemName: "book.closed").font(.system(size: 68, weight: .ultraLight)).foregroundStyle(.white.opacity(0.9))
                        Spacer()
                        Text(titles[index]).font(.system(.largeTitle, design: .serif))
                        Text(subtitles[index]).font(.title3).foregroundStyle(.white.opacity(0.8))
                        Text("STUDY \(index + 1) OF \(titles.count)").font(.caption).tracking(2).padding(.top, 12)
                    }
                    .padding(32).frame(maxWidth: .infinity, minHeight: 380, maxHeight: 470, alignment: .leading)
                    .foregroundStyle(.white).background(LinearGradient(colors: [.indigo, .teal], startPoint: .topLeading, endPoint: .bottomTrailing), in: .rect(cornerRadius: 32))
                    .overlay(alignment: .topTrailing) {
                        if abs(offset) > 30 { Text(offset > 0 ? "SAVE" : "SKIP").font(.headline).padding(12).background(.regularMaterial, in: Capsule()).padding(20) }
                    }
                    .rotationEffect(.degrees(Double(offset / 25))).offset(x: offset)
                    .gesture(DragGesture(minimumDistance: 15)
                        .updating($dragOffset) { value, offset, _ in
                            offset = !moving && abs(value.translation.width) > abs(value.translation.height) ? value.translation.width : 0
                        }
                        .onEnded { value in
                            guard !moving, abs(value.translation.width) > 100,
                                  abs(value.translation.width) > abs(value.translation.height) else { return }
                            decide(save: value.translation.width > 0, from: value.translation.width)
                        })
                    .accessibilityAction(named: "Save this card") { decide(save: true) }
                    .accessibilityAction(named: "Skip this card") { decide(save: false) }
                }
                HStack(spacing: 24) {
                    Button("Skip", systemImage: "arrow.right") { decide(save: false) }.buttonStyle(.bordered)
                    Button("Save", systemImage: "bookmark") { decide(save: true) }.buttonStyle(.borderedProminent).tint(.teal)
                }.controlSize(.large).disabled(moving)
            } else {
                ContentUnavailableView("You’re all caught up", systemImage: "checkmark.circle", description: Text("\(saved.count) saved · \(skipped) skipped"))
                Button("Start again") { index = 0; saved = []; skipped = 0 }.buttonStyle(.bordered)
            }
            Text("\(saved.count) saved · \(skipped) skipped").font(.footnote).foregroundStyle(.secondary)
            Spacer(minLength: 0)
        }.padding(24).frame(maxWidth: 650).frame(maxWidth: .infinity).clipped()
        .navigationTitle("Reading cards").navigationBarTitleDisplayMode(.inline)
        .onDisappear { cancelMove() }
        .accessibilityIdentifier("capture-ready")
    }
    private func decide(save: Bool, from dragOffset: CGFloat = 0) {
        guard index < titles.count, !moving else { return }
        let currentIndex = index
        let title = titles[currentIndex]
        exitOffset = dragOffset; moving = true
        withAnimation(reduceMotion ? nil : .easeIn(duration: 0.18)) { exitOffset = save ? 600 : -600 }
        moveTask = Task {
            if !reduceMotion {
                do { try await Task.sleep(for: .milliseconds(180)) } catch { return }
            }
            guard !Task.isCancelled, index == currentIndex else { return }
            if save { saved.append(title) } else { skipped += 1 }
            index += 1; exitOffset = 0; moving = false; moveTask = nil
        }
    }
    private func cancelMove() {
        moveTask?.cancel(); moveTask = nil
        var transaction = Transaction()
        transaction.disablesAnimations = true
        withTransaction(transaction) { exitOffset = 0; moving = false }
    }
}
#Preview { NavigationStack { SwipeableReadingCardsDemo() } }

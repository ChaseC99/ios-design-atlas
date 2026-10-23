import SwiftUI

@available(iOS 27.1, *)
struct ArrangementProportionsDemo: View {
    private let capturing = ProcessInfo.processInfo.arguments.contains("--capture")
    @State private var ratio = 1.5
    @State private var chapter = 1
    var body: some View {
        ArrangementView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text("CHAPTER \(chapter)").font(.caption).tracking(2).foregroundStyle(.secondary)
                    Text("The long\nway home.").font(.system(.largeTitle, design: .serif))
                    Text("Turn down the unfamiliar street. Look for the changing light. Some journeys are better with a little room left for curiosity.")
                        .font(.title3).lineSpacing(6)
                    if !capturing {
                        Text("Primary ratio: \(ratio, specifier: "%.1f")").font(.caption)
                        Slider(value: $ratio, in: 0.5...2.5, step: 0.1)
                    }
                }.padding(28)
            }.splitArrangementLayoutRatio(ratio)
        } secondary: {
            List(1...8, id: \.self) { number in
                Button { chapter = number } label: {
                    HStack {
                        Text("Chapter \(number)").foregroundStyle(.primary)
                        Spacer()
                        if chapter == number { Image(systemName: "checkmark").foregroundStyle(.teal) }
                    }.padding(.vertical, 8)
                }
            }.splitArrangementLayoutSize(minWidth: 220, idealWidth: 280, minHeight: 180)
        }
        .arrangementViewStyle(.split)
        .navigationTitle("Reading room").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
}
#Preview { if #available(iOS 27.1, *) { NavigationStack { ArrangementProportionsDemo() } } }

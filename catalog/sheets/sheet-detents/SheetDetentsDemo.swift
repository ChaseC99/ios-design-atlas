import SwiftUI

private struct RouteSummaryDetent: CustomPresentationDetent {
    static func height(in context: Context) -> CGFloat? {
        min(context.maxDetentValue, context.dynamicTypeSize.isAccessibilitySize ? 520 : 280)
    }
}

struct SheetDetentsDemo: View {
    private let isCapturing = ProcessInfo.processInfo.arguments.contains("--capture")
    @State private var isPresented = false
    @State private var kind = "Standard"
    @State private var selected: PresentationDetent = .medium

    private var lowerDetent: PresentationDetent {
        switch kind {
        case "Fixed": .height(280)
        case "Fraction": .fraction(0.35)
        case "Adaptive": .custom(RouteSummaryDetent.self)
        default: .medium
        }
    }

    var body: some View {
        Group {
            if isCapturing {
                Color(uiColor: .systemBackground).ignoresSafeArea()
            } else {
                Form {
                    Picker("Lower detent", selection: $kind) {
                        ForEach(["Standard", "Fixed", "Fraction", "Adaptive"], id: \.self) { Text($0) }
                    }
                    Button("Show route") {
                        selected = lowerDetent
                        isPresented = true
                    }
                    .accessibilityIdentifier("present")
                }
            }
        }
        .navigationTitle("Sheet detents")
        .sheet(isPresented: $isPresented) {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Label("WEEKEND WALK", systemImage: "figure.walk")
                        .font(.caption.weight(.semibold)).foregroundStyle(.secondary)
                    Text("The coastal path").font(.largeTitle.bold())
                    HStack(spacing: 28) {
                        Label("4.8 km", systemImage: "point.topleft.down.to.point.bottomright.curvepath")
                        Label("1 hr", systemImage: "clock")
                    }.foregroundStyle(.secondary)
                    Text("A quiet route along the water, with a stop at the old lighthouse.")
                    Button(selected == .large ? "Show summary" : "See route details") {
                        withAnimation { selected = selected == .large ? lowerDetent : .large }
                    }.buttonStyle(.borderedProminent)
                    if selected == .large {
                        Divider()
                        ForEach(["Harbor steps", "Cypress grove", "Old lighthouse"], id: \.self) { stop in
                            Label(stop, systemImage: "mappin.circle").font(.headline)
                        }
                    }
                    Button("Done") { isPresented = false }
                }.padding(28).frame(maxWidth: .infinity, alignment: .leading)
            }
            .presentationDetents([lowerDetent, .large], selection: $selected)
            .presentationDragIndicator(.visible)
            .accessibilityIdentifier("capture-ready")
        }
        .task { if isCapturing { isPresented = true } }
    }
}

#Preview { NavigationStack { SheetDetentsDemo() } }

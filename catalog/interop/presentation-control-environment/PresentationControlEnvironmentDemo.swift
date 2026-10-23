import SwiftUI

struct PresentationControlEnvironmentDemo: View {
    @State private var sheet = false
    @State private var popover = false
    @State private var reapply = false
    @State private var count = 3
    private let isCapturing = ProcessInfo.processInfo.arguments.contains("--capture")
    var body: some View {
        Group {
            if #available(iOS 26.0, *) { screen.buttonSizing(.flexible) }
            else { screen }
        }
        .controlSize(.large).buttonBorderShape(.roundedRectangle(radius: 6))
        .buttonRepeatBehavior(.enabled).menuIndicator(.hidden)
        .navigationTitle("Presentation defaults").navigationBarTitleDisplayMode(.inline)
        .task { if isCapturing { sheet = true } }
        .accessibilityIdentifier("capture-ready")
    }
    private var screen: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Text("A new presentation.\nA fresh context.").font(.system(.largeTitle, design: .serif).bold())
                ProbeControls(title: "Presenting view", count: $count)
                HStack {
                    Button("Sheet") { sheet = true }
                    Button("Popover") { popover = true }
                        .popover(isPresented: $popover) { presentation.padding(24).frame(idealWidth: 330).presentationCompactAdaptation(.popover) }
                }.buttonStyle(.borderedProminent)
            }.padding(24)
        }
        .sheet(isPresented: $sheet) {
            NavigationStack {
                presentation.padding(24)
                    .navigationTitle("Inside the sheet").navigationBarTitleDisplayMode(.inline)
                    .toolbar { ToolbarItem(placement: .confirmationAction) { Button("Done") { sheet = false } } }
            }.presentationDetents([.medium, .large]).presentationDragIndicator(.visible)
        }
    }
    private var presentation: some View {
        VStack(alignment: .leading, spacing: 24) {
            Group {
                if reapply {
                    if #available(iOS 26.0, *) { explicitlyStyled.buttonSizing(.flexible) }
                    else { explicitlyStyled }
                } else { ProbeControls(title: "Presentation", count: $count) }
            }
            Toggle("Apply the parent’s control style here", isOn: $reapply).font(.subheadline)
            Spacer(minLength: 0)
        }.accessibilityIdentifier("capture-ready")
    }
    private var explicitlyStyled: some View {
        ProbeControls(title: "Explicit local style", count: $count)
            .controlSize(.large).buttonBorderShape(.roundedRectangle(radius: 6))
            .buttonRepeatBehavior(.enabled).menuIndicator(.hidden)
    }
    private struct ProbeControls: View {
        @Environment(\.controlSize) private var size
        let title: String
        @Binding var count: Int
        var body: some View {
            VStack(alignment: .leading, spacing: 16) {
                Text(title).font(.headline)
                LabeledContent("Control size", value: String(describing: size).capitalized).font(.subheadline)
                if #available(iOS 26.0, *) { SizingReadout() }
                HStack {
                    Button("Add \(count)", systemImage: "plus") { count += 1 }.buttonStyle(.borderedProminent)
                    Menu("Options") { Button("Reset count") { count = 3 }; Button("Clear") { count = 0 } }.buttonStyle(.bordered)
                }
            }
        }
    }
    @available(iOS 26.0, *)
    private struct SizingReadout: View {
        @Environment(\.buttonSizing) private var sizing
        var body: some View { LabeledContent("Button sizing", value: sizing == .flexible ? "Flexible" : sizing == .fitted ? "Fitted" : sizing == .automatic ? "Automatic" : "Unknown").font(.subheadline) }
    }
}

#Preview { NavigationStack { PresentationControlEnvironmentDemo() } }

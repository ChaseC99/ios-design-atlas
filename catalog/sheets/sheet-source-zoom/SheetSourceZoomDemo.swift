import SwiftUI

struct SheetSourceZoomDemo: View {
    private let isCapturing = ProcessInfo.processInfo.arguments.contains("--capture")
    @Namespace private var transition
    @State private var isPresented = false
    @State private var usesZoom = true

    var body: some View {
        Group {
            if isCapturing {
                Color(uiColor: .systemBackground).ignoresSafeArea()
            } else {
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        Toggle("Zoom from the card", isOn: $usesZoom)
                        Button { isPresented = true } label: {
                            VStack(alignment: .leading, spacing: 18) {
                                Image(systemName: "sun.horizon.fill")
                                    .font(.system(size: 72))
                                Text("The coastal path").font(.title.bold())
                                Text("A walk worth taking slowly.").font(.subheadline)
                            }
                            .foregroundStyle(.primary)
                            .frame(maxWidth: .infinity, alignment: .leading).padding(28)
                            .background(.orange.opacity(0.16), in: RoundedRectangle(cornerRadius: 28))
                        }
                        .buttonStyle(.plain)
                        .matchedTransitionSource(id: "coast", in: transition)
                        .accessibilityIdentifier("present")
                    }.padding(24)
                }
            }
        }
        .navigationTitle("Sheets from a source view")
        .sheet(isPresented: $isPresented) {
            Group {
                if usesZoom {
                    destination.navigationTransition(.zoom(sourceID: "coast", in: transition))
                } else {
                    destination
                }
            }
            .accessibilityIdentifier("capture-ready")
        }
        .task { if isCapturing { isPresented = true } }
    }

    private var destination: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 28) {
                    Image(systemName: "sun.horizon.fill")
                        .font(.system(size: 96)).foregroundStyle(.orange)
                        .frame(maxWidth: .infinity).padding(.vertical, 50)
                        .background(.orange.opacity(0.12), in: RoundedRectangle(cornerRadius: 28))
                    Text("The coastal path").font(.largeTitle.bold())
                    Text("Follow the water, take a little longer, and stop when the view asks you to.")
                        .font(.title3).foregroundStyle(.secondary)
                    Label("4.8 km · About an hour", systemImage: "figure.walk")
                    Label("Start at the harbor steps", systemImage: "mappin")
                }.padding(28).frame(maxWidth: 640).frame(maxWidth: .infinity)
            }
            .navigationTitle("Weekend walks")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { Button("Done") { isPresented = false } }
        }
    }
}

#Preview { NavigationStack { SheetSourceZoomDemo() } }

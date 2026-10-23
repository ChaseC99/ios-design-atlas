import SwiftUI

struct NavigationZoomDemo: View {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @Namespace private var transition
    @State private var showsDetail = false
    @State private var previewReducedMotion = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 28) {
                    Button { showsDetail = true } label: {
                        VStack(alignment: .leading, spacing: 24) {
                            Image(systemName: "water.waves").font(.system(size: 64)).foregroundStyle(.teal)
                            Text("The coastal path").font(.title2.bold())
                            Text("4.8 km · Easy pace").foregroundStyle(.secondary)
                        }
                        .padding(28).frame(maxWidth: .infinity, alignment: .leading)
                        .background(.teal.opacity(0.1), in: RoundedRectangle(cornerRadius: 28))
                    }
                    .buttonStyle(.plain)
                    .matchedTransitionSource(id: "coast", in: transition)
                    .accessibilityIdentifier("capture-open")
                    Toggle("Preview reduced motion", isOn: $previewReducedMotion)
                }.padding(24).frame(maxWidth: 640).frame(maxWidth: .infinity)
            }
            .navigationTitle("Weekend walks")
            .navigationDestination(isPresented: $showsDetail) {
                Group {
                    if reduceMotion || previewReducedMotion { detail }
                    else { detail.navigationTransition(.zoom(sourceID: "coast", in: transition)) }
                }
                .navigationTitle("The coastal path")
                .navigationBarTitleDisplayMode(.inline)
                .accessibilityIdentifier("capture-ready")
            }
        }
    }

    private var detail: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 28) {
                Image(systemName: "water.waves").font(.system(size: 96)).foregroundStyle(.teal)
                    .frame(maxWidth: .infinity).padding(.vertical, 56)
                    .background(.teal.opacity(0.1), in: RoundedRectangle(cornerRadius: 28))
                Text("Take the long way home").font(.largeTitle.bold())
                Text("Follow the water past the old harbor. There is no need to hurry.").font(.title3).foregroundStyle(.secondary)
                Label("4.8 km · About an hour", systemImage: "figure.walk")
                Label("Start at the harbor steps", systemImage: "mappin")
            }.padding(28).frame(maxWidth: 640).frame(maxWidth: .infinity)
        }
    }
}

#Preview { NavigationZoomDemo() }

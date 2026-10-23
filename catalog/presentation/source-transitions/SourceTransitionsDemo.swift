import SwiftUI

struct SourceTransitionsDemo: View {
    @Namespace private var transition
    @State private var isPresented = false
    @State private var useZoom = true

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Text("Keep the origin in view")
                    .font(.largeTitle.bold())
                Text("Open the reference, dismiss it, then compare the default sheet transition with a source-linked zoom.")
                    .foregroundStyle(.secondary)
                Toggle("Use source zoom", isOn: $useZoom)
                Button { isPresented = true } label: {
                    VStack(alignment: .leading, spacing: 16) {
                        Image(systemName: "square.stack.3d.up.fill").font(.largeTitle)
                        Text("Presentation study").font(.title2.bold())
                        Text("Open reference").font(.subheadline)
                    }
                    .foregroundStyle(.white)
                    .padding(28)
                    .frame(maxWidth: .infinity, minHeight: 220, alignment: .leading)
                    .background(.indigo.gradient, in: RoundedRectangle(cornerRadius: 24))
                }
                .buttonStyle(.plain)
                .matchedTransitionSource(id: "reference", in: transition)
                .accessibilityIdentifier("present")
            }.padding(24)
        }
        .navigationTitle("Source transitions")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $isPresented) {
            if useZoom {
                detail.navigationTransition(.zoom(sourceID: "reference", in: transition))
            } else {
                detail
            }
        }
    }

    private var detail: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Image(systemName: "square.stack.3d.up.fill")
                        .font(.system(size: 64)).foregroundStyle(.indigo)
                    Text("Presentation study").font(.largeTitle.bold())
                    Text("The same reference, with more room to explore.")
                    Text("Watch the transition in the app. A still image documents the destination, not the animation between states.")
                        .foregroundStyle(.secondary)
                }.padding(28)
            }
            .navigationTitle("Reference")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") { isPresented = false }
                }
            }
        }
    }
}

#Preview { NavigationStack { SourceTransitionsDemo() } }

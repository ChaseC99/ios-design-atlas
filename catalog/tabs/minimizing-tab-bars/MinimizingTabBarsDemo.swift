import SwiftUI

@available(iOS 26.0, *)
struct MinimizingTabBarsDemo: View {
    private let isCapturing = ProcessInfo.processInfo.arguments.contains("--capture")
    @State private var behavior = 1
    private var minimizeBehavior: TabBarMinimizeBehavior {
        switch behavior { case 0: .automatic; case 1: .onScrollDown; case 2: .onScrollUp; default: .never }
    }
    var body: some View {
        TabView {
            Tab("Discover", systemImage: "sparkles") {
                NavigationStack {
                    ScrollView {
                        LazyVStack(alignment: .leading, spacing: 20) {
                            if !isCapturing {
                                Picker("Minimize", selection: $behavior) {
                                    Text("Auto").tag(0); Text("Down").tag(1); Text("Up").tag(2); Text("Never").tag(3)
                                }.pickerStyle(.segmented)
                            }
                            ForEach(0..<12, id: \.self) { index in
                                VStack(alignment: .leading, spacing: 0) {
                                    ZStack {
                                        Rectangle().fill([Color.indigo, .teal, .orange][index % 3].gradient)
                                        Image(systemName: ["moon.stars", "water.waves", "sun.horizon"][index % 3])
                                            .font(.system(size: 74)).foregroundStyle(.white.opacity(0.9))
                                    }.frame(height: 210)
                                    VStack(alignment: .leading, spacing: 6) {
                                        Text(["After the city sleeps", "A little closer to the coast", "The first light of day"][index % 3]).font(.title2.bold())
                                        Text("FIELD GUIDE · \(index + 4) MIN READ").font(.caption).foregroundStyle(.secondary)
                                    }.padding(20)
                                }.background(.background, in: .rect(cornerRadius: 24)).clipShape(.rect(cornerRadius: 24))
                            }
                        }.padding(20)
                    }.background(Color(uiColor: .systemGroupedBackground)).navigationTitle("Discover")
                }
            }
            Tab("Saved", systemImage: "bookmark") { ContentUnavailableView("Saved stories", systemImage: "bookmark") }
            Tab("Profile", systemImage: "person.crop.circle") { ContentUnavailableView("Your profile", systemImage: "person.crop.circle") }
        }
        .tabBarMinimizeBehavior(minimizeBehavior)
        .accessibilityIdentifier("capture-ready")
    }
}

@available(iOS 26.0, *)
#Preview { MinimizingTabBarsDemo() }

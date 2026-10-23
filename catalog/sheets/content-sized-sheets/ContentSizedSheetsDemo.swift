import SwiftUI

struct ContentSizedSheetsDemo: View {
    private let isCapturing = ProcessInfo.processInfo.arguments.contains("--capture")
    @State private var isPresented = false
    @State private var showsDetails = false

    var body: some View {
        Group {
            if isCapturing {
                Color(uiColor: .systemBackground).ignoresSafeArea()
            } else {
                Form {
                    Toggle("Start with details", isOn: $showsDetails)
                    Button("Show invitation") { isPresented = true }
                        .accessibilityIdentifier("present")
                }
            }
        }
        .navigationTitle("Content-sized sheets")
        .sheet(isPresented: $isPresented) {
            VStack(alignment: .leading, spacing: 24) {
                Image(systemName: "sun.horizon.fill")
                    .font(.system(size: 48)).foregroundStyle(.orange)
                Text("Saturday by the sea").font(.title.bold())
                Text("A morning walk, good coffee, and nowhere to rush.")
                    .foregroundStyle(.secondary)
                Toggle("Show the plan", isOn: $showsDetails)
                if showsDetails {
                    Divider()
                    Label("9:00 AM · Harbor steps", systemImage: "clock")
                    Label("Bring a light jacket", systemImage: "wind")
                    Label("Coffee at the lighthouse", systemImage: "cup.and.saucer")
                }
                Button("Sounds good") { isPresented = false }
                    .buttonStyle(.borderedProminent).controlSize(.large)
                    .frame(maxWidth: .infinity)
            }
            .padding(28)
            .frame(minWidth: 280, idealWidth: 360, maxWidth: 420)
            .animation(.snappy, value: showsDetails)
            .presentationSizing(.fitted.sticky(horizontal: true))
            .accessibilityIdentifier("capture-ready")
        }
        .task { if isCapturing { isPresented = true } }
    }
}

#Preview { NavigationStack { ContentSizedSheetsDemo() } }

import SwiftUI

struct OnboardingPreferencesDemo: View {
    @State private var page = 0
    @State private var travel = true
    @State private var reading = true
    @State private var completed = false
    var body: some View {
        VStack(spacing: 20) {
            if completed {
                ContentUnavailableView("Make yourself at home", systemImage: "checkmark.circle", description: Text("Your preferences are ready for this session."))
            } else {
                TabView(selection: $page) {
                    VStack(alignment: .leading, spacing: 24) {
                        Image(systemName: "sparkles").font(.system(size: 85)).foregroundStyle(.indigo).padding(.bottom, 16)
                        Text("A little place\nfor good things.").font(.system(.largeTitle, design: .serif).bold())
                        Text("Keep a few ideas, find a new favorite, and leave room for discovery.").font(.title3).foregroundStyle(.secondary)
                    }.frame(maxWidth: .infinity, alignment: .leading).padding(32).tag(0)
                    VStack(alignment: .leading, spacing: 24) {
                        Text("Your kind of inspiration.").font(.largeTitle.bold())
                        Toggle("Places and small adventures", isOn: $travel)
                        Toggle("Reading and creative ideas", isOn: $reading)
                        Text("You can change these choices anytime.").foregroundStyle(.secondary)
                    }.padding(32).tag(1)
                }.tabViewStyle(.page(indexDisplayMode: .always)).indexViewStyle(.page(backgroundDisplayMode: .always))
            }
            Button(completed ? "Start again" : page == 0 ? "Continue" : "Get started") {
                if completed { completed = false; page = 0 } else if page == 0 { withAnimation { page = 1 } } else { completed = true }
            }.buttonStyle(.borderedProminent).controlSize(.large).padding(.bottom, 28)
        }
        .navigationTitle("Welcome").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
}

#Preview { NavigationStack { OnboardingPreferencesDemo() } }

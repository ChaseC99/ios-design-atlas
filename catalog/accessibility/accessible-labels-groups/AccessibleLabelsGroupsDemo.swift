import SwiftUI

struct AccessibleLabelsGroupsDemo: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 28) {
                Text("Your next chapter").font(.largeTitle.bold()).accessibilityAddTraits(.isHeader).accessibilitySortPriority(2)
                VStack(alignment: .leading, spacing: 22) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 24).fill(.indigo.gradient)
                        Image(systemName: "moon.stars.fill").font(.system(size: 80)).foregroundStyle(.white.opacity(0.9))
                    }.frame(height: 230).accessibilityHidden(true)
                    VStack(alignment: .leading, spacing: 8) {
                        Text("After the city sleeps").font(.title2.bold())
                        Text("Atlas Journal · 8 min read").foregroundStyle(.secondary)
                        Label("Saved for later", systemImage: "bookmark.fill").font(.subheadline).foregroundStyle(.indigo)
                    }
                }
                .accessibilityElement(children: .ignore)
                .accessibilityLabel("After the city sleeps")
                .accessibilityValue("Atlas Journal. Eight minute read. Saved for later.")
                .accessibilitySortPriority(1)
                Text("A quieter view of familiar streets, and a little inspiration for the hours between.").foregroundStyle(.secondary)
            }.padding(24)
        }
        .navigationTitle("Reading list").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
}

#Preview { NavigationStack { AccessibleLabelsGroupsDemo() } }

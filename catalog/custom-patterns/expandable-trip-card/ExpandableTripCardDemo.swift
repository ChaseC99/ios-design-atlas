import SwiftUI

struct ExpandableTripCardDemo: View {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var expanded = true
    @State private var saved = false
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 28) {
                Text("Room to wander.").font(.system(.largeTitle, design: .serif))
                VStack(alignment: .leading, spacing: 0) {
                    RoundedRectangle(cornerRadius: 24).fill(.teal.gradient)
                        .frame(height: 180).overlay(Image(systemName: "mountain.2").font(.system(size: 74, weight: .ultraLight)).foregroundStyle(.white))
                        .padding(12)
                    Button {
                        withAnimation(reduceMotion ? nil : .snappy) { expanded.toggle() }
                    } label: {
                        HStack(spacing: 18) {
                            VStack(alignment: .leading, spacing: 7) {
                                Text("The coastal trail").font(.title2.weight(.semibold))
                                Text("Saturday · A day outside").font(.subheadline).foregroundStyle(.secondary)
                            }
                            Spacer()
                            Image(systemName: "chevron.down").rotationEffect(.degrees(expanded ? 180 : 0)).foregroundStyle(.secondary)
                        }.padding(24).contentShape(Rectangle())
                    }.buttonStyle(.plain).accessibilityValue(expanded ? "Expanded" : "Collapsed")
                    if expanded {
                        VStack(alignment: .leading, spacing: 20) {
                            Divider()
                            HStack(alignment: .top) {
                                Label("4 stops", systemImage: "mappin.and.ellipse")
                                Spacer()
                                Label("Easy pace", systemImage: "figure.walk")
                            }.font(.subheadline)
                            Text("A quiet morning, a long lunch, and a little time with the ocean.").foregroundStyle(.secondary)
                            Button(saved ? "Saved to plans" : "Save to plans", systemImage: saved ? "checkmark" : "bookmark") { saved.toggle() }
                                .buttonStyle(.borderedProminent).tint(.teal)
                        }.padding([.horizontal, .bottom], 24).transition(.opacity.combined(with: .move(edge: .top)))
                    }
                }
                .background(Color(uiColor: .secondarySystemBackground), in: .rect(cornerRadius: 32))
                Label("City gardens", systemImage: "leaf").font(.headline).padding(24).frame(maxWidth: .infinity, alignment: .leading)
                    .background(.green.opacity(0.08), in: .rect(cornerRadius: 24))
            }.padding(24).frame(maxWidth: 700).frame(maxWidth: .infinity)
        }
        .navigationTitle("Weekend plans").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
}
#Preview { NavigationStack { ExpandableTripCardDemo() } }

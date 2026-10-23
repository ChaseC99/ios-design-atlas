import SwiftUI

struct StandardTabsDemo: View {
    @State private var selected = 0
    @State private var unread = 3
    var body: some View {
        TabView(selection: $selected) {
            Tab("Today", systemImage: "sun.max", value: 0) {
                NavigationStack {
                    List {
                        Section {
                            VStack(alignment: .leading, spacing: 14) {
                                Image(systemName: "sun.horizon.fill").font(.system(size: 44)).foregroundStyle(.orange)
                                Text("Make room for\nsomething good.").font(.system(.largeTitle, design: .serif).weight(.medium))
                                Text("A few things worth keeping close.").foregroundStyle(.secondary)
                            }.padding(.vertical, 18)
                        }
                        Section("Your day") {
                            Label("Morning pages", systemImage: "book.pages")
                            Label("A walk without a destination", systemImage: "figure.walk")
                            Button("Read your inbox") { selected = 1 }
                        }
                    }.navigationTitle("Today")
                }
            }
            Tab("Inbox", systemImage: "tray", value: 1) {
                NavigationStack {
                    List {
                        ForEach(1...3, id: \.self) { index in
                            Label("A note for you · \(index)", systemImage: "envelope")
                        }
                        Button("Mark all as read") { unread = 0 }
                    }.navigationTitle("Inbox")
                }
            }.badge(unread)
            Tab("Saved", systemImage: "bookmark", value: 2) {
                NavigationStack {
                    ContentUnavailableView("Your favorites live here", systemImage: "bookmark", description: Text("Keep a little inspiration for later."))
                        .navigationTitle("Saved")
                }
            }
        }
        .accessibilityIdentifier("capture-ready")
    }
}

#Preview { StandardTabsDemo() }

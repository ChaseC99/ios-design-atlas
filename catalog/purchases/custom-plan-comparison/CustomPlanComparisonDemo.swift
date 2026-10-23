import SwiftUI
import StoreKit
import Foundation

struct CustomPlanComparisonDemo: View {
    @State private var products: [Product] = []
    @State private var selected = "dev.iosdesignatlas.fixture.plus.yearly"
    @State private var loading = true
    private let ids = ["dev.iosdesignatlas.fixture.plus.monthly", "dev.iosdesignatlas.fixture.plus.yearly"]
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                Image(systemName: "square.stack.3d.up.fill").font(.system(size: 36)).foregroundStyle(.indigo)
                Text("For everything\nyou want to keep.").font(.system(.title, design: .serif).bold())
                VStack(alignment: .leading, spacing: 14) {
                    Label("Unlimited collections", systemImage: "square.stack")
                    Label("Every theme and icon", systemImage: "paintpalette")
                    Label("More room for your ideas", systemImage: "sparkles")
                }.foregroundStyle(.secondary)
                if products.count == 2 {
                    VStack(spacing: 12) {
                        ForEach(products) { product in
                            Button { selected = product.id } label: {
                                HStack {
                                    Image(systemName: selected == product.id ? "checkmark.circle.fill" : "circle").foregroundStyle(.indigo)
                                    VStack(alignment: .leading, spacing: 4) { Text(product.displayName).font(.headline); Text(period(product)).font(.caption).foregroundStyle(.secondary) }
                                    Spacer()
                                    Text(product.displayPrice).font(.title3.weight(.semibold))
                                }.foregroundStyle(.primary).padding(18)
                                    .background(selected == product.id ? Color.indigo.opacity(0.08) : Color(uiColor: .secondarySystemGroupedBackground), in: .rect(cornerRadius: 18))
                                    .overlay { RoundedRectangle(cornerRadius: 18).stroke(selected == product.id ? Color.indigo : .clear, lineWidth: 1.5) }
                            }.buttonStyle(.plain).accessibilityAddTraits(selected == product.id ? .isSelected : [])
                        }
                    }.accessibilityIdentifier("storekit-products-loaded")
                    if let product = products.first(where: { $0.id == selected }) {
                        ProductView(product) {
                            Image(systemName: "square.stack.3d.up.fill")
                                .font(.system(size: 28)).foregroundStyle(.white)
                                .frame(width: 64, height: 64)
                                .background(.indigo.gradient, in: .rect(cornerRadius: 16))
                        }.productViewStyle(.compact)
                        Text("Renews automatically until cancelled. Manage your plan in App Store subscriptions.").font(.footnote).foregroundStyle(.secondary)
                    }
                } else if loading { ProgressView("Loading local plans…") }
                else { ContentUnavailableView("Local plans unavailable", systemImage: "bag", description: Text("Enable AtlasPurchases.storekit in Xcode.")) }
            }.padding(26)
        }
        .task {
            let fetched = (try? await Product.products(for: ids)) ?? []
            products = ids.compactMap { id in fetched.first { $0.id == id } }; loading = false
        }
        .onInAppPurchaseCompletion { _, result in
            if case .success(.success(.verified(let transaction))) = result { await transaction.finish() }
        }
        .navigationTitle("Make it yours").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
    private func period(_ product: Product) -> String {
        guard let period = product.subscription?.subscriptionPeriod else { return "One-time purchase" }
        switch period.unit {
        case .month: return period.value == 1 ? "Billed monthly" : "Every \(period.value) months"
        case .year: return period.value == 1 ? "Billed yearly" : "Every \(period.value) years"
        case .week: return period.value == 1 ? "Billed weekly" : "Every \(period.value) weeks"
        case .day: return period.value == 1 ? "Billed daily" : "Every \(period.value) days"
        @unknown default: return "Recurring subscription"
        }
    }
}

#Preview { NavigationStack { CustomPlanComparisonDemo() } }

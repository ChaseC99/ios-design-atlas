import SwiftUI
import StoreKit
import Foundation

struct StoreKitSubscriptionViewDemo: View {
    @State private var products: [Product] = []
    @State private var loading = true
    @State private var attempt = 0
    private let ids = ["dev.iosdesignatlas.fixture.plus.monthly", "dev.iosdesignatlas.fixture.plus.yearly"]
    var body: some View {
        Group {
            if products.count == 2 {
                SubscriptionStoreView(subscriptions: products) {
                    VStack(spacing: 14) {
                        Image(systemName: "sparkles").font(.system(size: 52)).foregroundStyle(.indigo)
                        Text("A little more possibility.").font(.system(.largeTitle, design: .serif).bold()).multilineTextAlignment(.center)
                        Text("Unlimited collections, thoughtful themes, and room for every idea.").foregroundStyle(.secondary).multilineTextAlignment(.center)
                    }.padding(.horizontal, 26).padding(.vertical, 22)
                }
                .subscriptionStoreControlStyle(.prominentPicker)
                .subscriptionStoreButtonLabel(.multiline)
                .storeButton(.visible, for: .restorePurchases)
                .storeButton(.hidden, for: .cancellation)
                .subscriptionStorePolicyDestination(for: .privacyPolicy) { Text("Local design example. No account or analytics data is collected by this demonstration.").padding() }
                .subscriptionStorePolicyDestination(for: .termsOfService) { Text("Fictional products for local StoreKit testing. This example grants no real service.").padding() }
                .accessibilityIdentifier("storekit-products-loaded")
            } else if loading { ProgressView("Loading local plans…") }
            else {
                VStack {
                    ContentUnavailableView("Local plans unavailable", systemImage: "sparkles", description: Text("Run with AtlasPurchases.storekit enabled in Xcode."))
                    Button("Retry loading") { attempt += 1 }
                }
            }
        }
        .task(id: attempt) {
            loading = true
            let fetched = (try? await Product.products(for: ids)) ?? []
            products = ids.compactMap { id in fetched.first { $0.id == id } }
            loading = false
        }
        .onInAppPurchaseCompletion { _, result in
            if case .success(.success(.verified(let transaction))) = result { await transaction.finish() }
        }
        .navigationTitle("Atlas Plus").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
}

#Preview { NavigationStack { StoreKitSubscriptionViewDemo() } }

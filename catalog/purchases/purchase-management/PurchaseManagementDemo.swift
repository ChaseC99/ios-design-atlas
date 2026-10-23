import SwiftUI
import StoreKit
import Foundation

struct PurchaseManagementDemo: View {
    @State private var owned: Set<String> = []
    @State private var products: [Product] = []
    @State private var status = "Checking local access…"
    @State private var loading = true
    @State private var restoring = false
    @State private var manage = false
    @State private var redeem = false
    @State private var feedback: String?
    private let ids = ["dev.iosdesignatlas.fixture.notes", "dev.iosdesignatlas.fixture.icons", "dev.iosdesignatlas.fixture.colors", "dev.iosdesignatlas.fixture.plus.monthly", "dev.iosdesignatlas.fixture.plus.yearly"]
    var body: some View {
        Group {
            if #available(iOS 27.0, *) {
                content.offerCodeRedemption(options: [], isPresented: $redeem) { result in
                    Task {
                        if case .success(.verified(let transaction)) = result { await transaction.finish(); await refresh() }
                        else { feedback = "No verified offer redemption was received." }
                    }
                }
            } else {
                content.offerCodeRedemption(isPresented: $redeem) { result in
                    Task { if case .success = result { await refresh() } else { feedback = "Offer redemption did not complete." } }
                }
            }
        }
        .manageSubscriptionsSheet(isPresented: $manage, subscriptionGroupID: "31000001")
        .task { await refresh() }
        .navigationTitle("Your access").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("capture-ready")
    }
    private var content: some View {
        Form {
            Section {
                VStack(alignment: .leading, spacing: 14) {
                    Image(systemName: owned.isEmpty ? "sparkles" : "checkmark.seal.fill").font(.system(size: 44)).foregroundStyle(.indigo)
                    Text(owned.isEmpty ? "A good place to begin." : "Your collection has more room.").font(.system(.title, design: .serif).bold())
                    Text(status).foregroundStyle(.secondary)
                }.padding(.vertical, 18)
            }
            if !products.isEmpty {
                Section("Verified local access") {
                    LabeledContent("Purchased products", value: "\(owned.count)")
                    ForEach(products.filter { owned.contains($0.id) }) { product in Label(product.displayName, systemImage: "checkmark.circle") }
                }.accessibilityIdentifier("storekit-products-loaded")
            } else if loading { ProgressView("Loading local products…") }
            else { Text("Enable AtlasPurchases.storekit in Xcode to inspect fictional products.").foregroundStyle(.secondary) }
            Section("Purchases") {
                Button(restoring ? "Restoring…" : "Restore purchases", systemImage: "arrow.clockwise") {
                    Task {
                        restoring = true
                        do { try await AppStore.sync(); await refresh(); feedback = "Restore completed. Access reflects verified entitlements." }
                        catch { feedback = "Restore could not complete: \(error.localizedDescription)" }
                        restoring = false
                    }
                }.disabled(restoring || products.isEmpty)
                Button("Manage subscriptions", systemImage: "creditcard") { manage = true }.disabled(products.isEmpty)
                Button("Redeem an offer code", systemImage: "gift") { redeem = true }.disabled(products.isEmpty)
            }
            if let feedback { Section { Text(feedback).font(.subheadline).foregroundStyle(.secondary) } }
        }
    }
    private func refresh() async {
        loading = true
        do {
            products = try await Product.products(for: ids)
            var verified: Set<String> = []
            for await result in Transaction.currentEntitlements {
                if case .verified(let transaction) = result, ids.contains(transaction.productID) { verified.insert(transaction.productID) }
            }
            owned = verified
            if let subscription = products.first(where: { $0.subscription != nil })?.subscription {
                let statuses = try await subscription.status
                let hasVerifiedSubscription = statuses.contains { entry in
                    guard case .verified(let transaction) = entry.transaction, verified.contains(transaction.productID) else { return false }
                    return entry.state == .subscribed || entry.state == .inGracePeriod
                }
                status = hasVerifiedSubscription ? "Atlas Plus access is active." : verified.isEmpty ? "No local purchases yet." : "Your verified packs are ready."
            } else { status = "Local StoreKit configuration is not available." }
        } catch { status = "Could not read local purchase status." }
        loading = false
    }
}

#Preview { NavigationStack { PurchaseManagementDemo() } }

import SwiftUI
import AVFoundation
import Photos
import PhotosUI
import CoreLocation
import UserNotifications
import UIKit
import Combine

struct ContextualPermissionsDemo: View {
    @Environment(\.openURL) private var openURL
    @Environment(\.scenePhase) private var scenePhase
    @StateObject private var location = AtlasLocationPermission()
    @State private var notificationStatus = "Checking…"
    @State private var photo: PhotosPickerItem?
    @State private var revision = 0
    @State private var outcome = "No access requested by this example"
    private enum Resource: String, CaseIterable {
        case camera = "Camera", microphone = "Microphone", photos = "Photos", location = "Location", notifications = "Notifications"
        var key: String? {
            switch self {
            case .camera: "NSCameraUsageDescription"
            case .microphone: "NSMicrophoneUsageDescription"
            case .photos: "NSPhotoLibraryUsageDescription"
            case .location: "NSLocationWhenInUseUsageDescription"
            case .notifications: nil
            }
        }
        var symbol: String {
            switch self { case .camera: "camera"; case .microphone: "mic"; case .photos: "photo"; case .location: "location"; case .notifications: "bell" }
        }
    }
    var body: some View {
        Form {
            Section {
                Label("Your access, your choice", systemImage: "hand.raised.fill").font(.title2.bold()).foregroundStyle(.teal)
                Text("Each request belongs to the action you choose.").foregroundStyle(.secondary)
            }
            Section("Device access") {
                ForEach(Resource.allCases, id: \.self) { resource in
                    HStack(spacing: 14) {
                        Image(systemName: resource.symbol).font(.title3).foregroundStyle(.teal).frame(width: 28)
                        VStack(alignment: .leading, spacing: 4) {
                            Text(resource.rawValue).font(.headline)
                            Text(configured(resource) ? state(resource) : "Usage description required").font(.caption).foregroundStyle(.secondary)
                        }
                        Spacer()
                        Button("Request") { request(resource) }.buttonStyle(.borderless).disabled(!configured(resource))
                            .accessibilityLabel("Request \(resource.rawValue.lowercased()) access")
                    }.padding(.vertical, 6)
                }
            }
            Section("Specific access") {
                PhotosPicker(selection: $photo, matching: .images) { Label("Choose one photo", systemImage: "photo.badge.plus") }
                Button("Open this app’s Settings", systemImage: "gear") { openURL(URL(string: UIApplication.openSettingsURLString)!) }
                Text(outcome).font(.caption).foregroundStyle(.secondary)
            }
            Section {
                Text("Camera, microphone, full photo-library access, and location need their matching usage-description keys in the app target.").font(.caption).foregroundStyle(.secondary)
            }
        }
        .navigationTitle("Permissions in context").navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier(notificationStatus == "Checking…" ? "permissions-loading" : "capture-ready")
        .task { await refreshNotifications() }
        .onChange(of: scenePhase) { _, phase in if phase == .active { revision += 1; Task { await refreshNotifications() } } }
        .onChange(of: photo) { _, item in if item != nil { outcome = "One photo selected · Contents not loaded" } }
    }
    private func configured(_ resource: Resource) -> Bool {
        guard let key = resource.key else { return true }
        return !(Bundle.main.object(forInfoDictionaryKey: key) as? String ?? "").isEmpty
    }
    private func state(_ resource: Resource) -> String {
        _ = revision
        switch resource {
        case .camera, .microphone:
            switch AVCaptureDevice.authorizationStatus(for: resource == .camera ? .video : .audio) {
            case .notDetermined: return "Not requested"
            case .restricted: return "Restricted"
            case .denied: return "Denied"
            case .authorized: return "Allowed"
            @unknown default: return "Unknown"
            }
        case .photos:
            switch PHPhotoLibrary.authorizationStatus(for: .readWrite) {
            case .notDetermined: return "Not requested"
            case .restricted: return "Restricted"
            case .denied: return "Denied"
            case .authorized: return "Full access"
            case .limited: return "Limited selection"
            @unknown default: return "Unknown"
            }
        case .location:
            switch location.status {
            case .notDetermined: return "Not requested"
            case .restricted: return "Restricted"
            case .denied: return "Denied"
            case .authorizedAlways: return "Always allowed"
            case .authorizedWhenInUse: return "While using the app"
            @unknown default: return "Unknown"
            }
        case .notifications: return notificationStatus
        }
    }
    private func request(_ resource: Resource) {
        guard configured(resource) else { outcome = "Add the required usage description first"; return }
        if resource == .location { location.request(); outcome = "Location authorization requested · No location read"; return }
        Task {
            switch resource {
            case .camera, .microphone: _ = await AVCaptureDevice.requestAccess(for: resource == .camera ? .video : .audio)
            case .photos: _ = await PHPhotoLibrary.requestAuthorization(for: .readWrite)
            case .notifications:
                do { _ = try await UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) }
                catch { outcome = "Notification authorization failed"; return }
                await refreshNotifications()
            case .location: break
            }
            revision += 1
            outcome = "\(resource.rawValue): \(state(resource))"
        }
    }
    private func refreshNotifications() async {
        let settings = await UNUserNotificationCenter.current().notificationSettings()
        switch settings.authorizationStatus {
        case .notDetermined: notificationStatus = "Not requested"
        case .denied: notificationStatus = "Denied"
        case .authorized: notificationStatus = "Allowed"
        case .provisional: notificationStatus = "Provisional"
        case .ephemeral: notificationStatus = "Temporary"
        @unknown default: notificationStatus = "Unknown"
        }
    }
}
@MainActor private final class AtlasLocationPermission: NSObject, ObservableObject, @preconcurrency CLLocationManagerDelegate {
    @Published var status = CLAuthorizationStatus.notDetermined
    private let manager = CLLocationManager()
    override init() {
        super.init(); manager.delegate = self; status = manager.authorizationStatus
    }
    func request() { manager.requestWhenInUseAuthorization() }
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) { status = manager.authorizationStatus }
}

#Preview { NavigationStack { ContextualPermissionsDemo() } }

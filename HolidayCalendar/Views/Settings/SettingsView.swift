import SwiftUI

/// SettingsView
/// Rule 3.3: List with NavigationLink("Countries")
/// Step 19: Added Notifications Permission Management section
struct SettingsView: View {
    @State private var notificationManager = NotificationManager.shared
    @AppStorage("enableHolidayAlerts") private var enableHolidayAlerts: Bool = true

    var body: some View {
        NavigationStack {
            List {
                // Section 1: Preferences & Countries Selection
                Section("Preferences") {
                    NavigationLink("Countries") {
                        CountrySelectionView()
                    }
                }

                // Section 2: Notifications
                Section("Notifications") {
                    HStack {
                        Label("Notification Access", systemImage: "bell.badge")

                        Spacer()

                        if notificationManager.isAuthorized {
                            Text("Allowed")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundStyle(.green)
                        } else {
                            Button("Enable") {
                                notificationManager.requestAuthorization()
                            }
                            .font(.caption)
                            .fontWeight(.semibold)
                            .buttonStyle(.borderedProminent)
                        }
                    }

                    Toggle("Holiday Morning Alerts", isOn: $enableHolidayAlerts)
                }

                // Section 3: App Information
                Section("About") {
                    HStack {
                        Text("App Version")
                        Spacer()
                        Text("1.0.0 (Build 1)")
                            .foregroundStyle(.secondary)
                    }

                    HStack {
                        Text("Developer")
                        Spacer()
                        Text("Holiday Calendar Team")
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .navigationTitle("Settings")
            .onAppear {
                notificationManager.checkAuthorizationStatus()
            }
        }
    }
}

#Preview {
    SettingsView()
}

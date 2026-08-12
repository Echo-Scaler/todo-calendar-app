import SwiftUI

/// SettingsView placeholder
/// Rule 3.2: NavigationStack နဲ့ .navigationTitle("Settings") ပါဝင်ရမည်
/// Rule 3.3: List ထဲ NavigationLink("Countries") ပါရမည်၊ CountrySelectionView ကို destination အနေနဲ့ link လုပ်ရမည်
struct SettingsView: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("Countries") {
                    CountrySelectionView()
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}

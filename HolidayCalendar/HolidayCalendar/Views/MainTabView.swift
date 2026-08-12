import SwiftUI

/// Main tab navigation view
/// Rule 2.1: Tab ၄ ခု — Calendar → Todo → Memo → Settings
/// Rule 2.2: Calendar tab ကို default selected ထားရမယ်
/// Rule 2.3: SF Symbols အတိုင်း icon သုံးရမယ်
struct MainTabView: View {
    var body: some View {
        TabView {
            CalendarView()
                .tabItem {
                    Label("Calendar", systemImage: "calendar")
                }

            TodoListView()
                .tabItem {
                    Label("Todo", systemImage: "checkmark.circle")
                }

            MemoListView()
                .tabItem {
                    Label("Memo", systemImage: "note.text")
                }

            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
        }
    }
}

#Preview {
    MainTabView()
}

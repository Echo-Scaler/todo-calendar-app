import SwiftUI

/// App entry point for HolidayCalendar
/// Rule 2.5: MainTabView() ကို root view အနေနဲ့ set လုပ်ရမယ်
@main
struct HolidayCalendarApp: App {
    var body: some Scene {
        WindowGroup {
            MainTabView()
        }
    }
}

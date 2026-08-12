import SwiftUI

/// App entry point for HolidayCalendar
/// Rule 2.5: MainTabView() ကို root view အနေနဲ့ set လုပ်ရမယ် (Step 2 မှာ update လုပ်ပါမယ်)
@main
struct HolidayCalendarApp: App {
    var body: some Scene {
        WindowGroup {
            Text("Holiday Calendar")
        }
    }
}

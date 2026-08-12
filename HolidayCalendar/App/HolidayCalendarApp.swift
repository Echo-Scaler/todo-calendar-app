import SwiftUI

/// App entry point for HolidayCalendar
/// Rule 8.1 & 8.2: CountryViewModel ကို @State နဲ့ create ပြီး .environment() နဲ့ inject လုပ်မည်
@main
struct HolidayCalendarApp: App {
    @State private var countryViewModel = CountryViewModel()

    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environment(countryViewModel)
        }
    }
}

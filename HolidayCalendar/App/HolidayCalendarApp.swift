import SwiftUI
import SwiftData

/// App entry point for HolidayCalendar
/// Rule 8.1 & 8.2: CountryViewModel injected via environment
/// Step 14: SwiftData ModelContainer configured for TodoItem and MemoItem
@main
struct HolidayCalendarApp: App {
    @State private var countryViewModel = CountryViewModel()

    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environment(countryViewModel)
        }
        .modelContainer(for: [TodoItem.self, MemoItem.self])
    }
}

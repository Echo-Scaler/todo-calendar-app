import Foundation
import Observation

/// CalendarViewModel
/// Manages month navigation, day grid calculations, and date selection
@Observable
final class CalendarViewModel {
    var currentMonth: Date
    var selectedDate: Date

    private let calendar = Calendar.current

    init(initialDate: Date = Date()) {
        self.currentMonth = initialDate
        self.selectedDate = initialDate
    }

    // MARK: - Navigation Actions

    func nextMonth() {
        if let next = calendar.date(byAdding: .month, value: 1, to: currentMonth) {
            currentMonth = next
        }
    }

    func previousMonth() {
        if let prev = calendar.date(byAdding: .month, value: -1, to: currentMonth) {
            currentMonth = prev
        }
    }

    func goToToday() {
        let now = Date()
        currentMonth = now
        selectedDate = now
    }

    func selectDate(_ date: Date) {
        selectedDate = date
    }

    // MARK: - Grid Calculations

    /// Computes the 7-column grid of dates for the `currentMonth`.
    /// Leading empty days before the 1st of the month are `nil`.
    var daysInMonthGrid: [Date?] {
        guard let monthInterval = calendar.dateInterval(of: .month, for: currentMonth),
              let firstDayOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: currentMonth)) else {
            return []
        }

        // Get weekday of 1st day of month (1 = Sunday, 7 = Saturday)
        let firstWeekday = calendar.component(.weekday, from: firstDayOfMonth)
        let leadingPaddingCount = firstWeekday - 1

        // Total number of days in the month
        let numberOfDays = calendar.range(of: .day, in: .month, for: currentMonth)?.count ?? 0

        var days: [Date?] = Array(repeating: nil, count: leadingPaddingCount)

        for day in 1...numberOfDays {
            if let date = calendar.date(byAdding: .day, value: day - 1, to: firstDayOfMonth) {
                days.append(date)
            }
        }

        return days
    }

    // MARK: - Formatting Helpers

    var monthYearTitle: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: currentMonth)
    }

    var selectedDateTitle: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter.string(from: selectedDate)
    }

    // MARK: - Comparison Helpers

    func isToday(_ date: Date) -> Bool {
        calendar.isDateInToday(date)
    }

    func isSelected(_ date: Date) -> Bool {
        calendar.isDate(date, inSameDayAs: selectedDate)
    }

    func isSameMonth(_ date: Date) -> Bool {
        calendar.isDate(date, equalTo: currentMonth, toGranularity: .month)
    }
}

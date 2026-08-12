import SwiftUI

/// CalendarView
/// Main Calendar view with monthly grid, date selection, country indicators, active filters bar, and holiday events feed
struct CalendarView: View {
    @Environment(CountryViewModel.self) private var countryViewModel
    @State private var calendarViewModel = CalendarViewModel()

    private let weekdaySymbols = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    private let gridColumns = Array(repeating: GridItem(.flexible(), spacing: 4), count: 7)

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    // MARK: 1. Month Header & Navigation Controls
                    monthHeaderView

                    // MARK: 2. Weekday Header Row
                    weekdayHeaderView

                    // MARK: 3. Monthly Days Grid
                    daysGridView

                    Divider()
                        .padding(.vertical, 4)

                    // MARK: 4. Active Selected Countries Bar
                    selectedCountriesBar

                    // MARK: 5. Selected Date Event Feed
                    selectedDateEventsFeed
                }
                .padding(.horizontal)
                .padding(.bottom, 24)
            }
            .navigationTitle("Calendar")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Today") {
                        withAnimation {
                            calendarViewModel.goToToday()
                        }
                    }
                    .font(.subheadline)
                    .fontWeight(.semibold)
                }
            }
        }
    }

    // MARK: - Subviews

    /// Month Header with Prev/Next controls
    private var monthHeaderView: some View {
        HStack {
            Button(action: {
                withAnimation {
                    calendarViewModel.previousMonth()
                }
            }) {
                Image(systemName: "chevron.left.circle.fill")
                    .font(.title2)
                    .foregroundStyle(.blue)
            }

            Spacer()

            Text(calendarViewModel.monthYearTitle)
                .font(.title2)
                .fontWeight(.bold)

            Spacer()

            Button(action: {
                withAnimation {
                    calendarViewModel.nextMonth()
                }
            }) {
                Image(systemName: "chevron.right.circle.fill")
                    .font(.title2)
                    .foregroundStyle(.blue)
            }
        }
        .padding(.vertical, 8)
    }

    /// Weekday Column Headers
    private var weekdayHeaderView: some View {
        LazyVGrid(columns: gridColumns, spacing: 4) {
            ForEach(weekdaySymbols, id: \.self) { symbol in
                Text(symbol)
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundStyle(symbol == "Sun" ? .red : (symbol == "Sat" ? .blue : .secondary))
                    .frame(maxWidth: .infinity)
            }
        }
    }

    /// Monthly Days Grid View
    private var daysGridView: some View {
        LazyVGrid(columns: gridColumns, spacing: 8) {
            ForEach(0..<calendarViewModel.daysInMonthGrid.count, id: \.self) { index in
                if let date = calendarViewModel.daysInMonthGrid[index] {
                    dayCellView(for: date)
                } else {
                    // Empty cell for alignment before 1st of month
                    Color.clear
                        .frame(height: 48)
                }
            }
        }
    }

    /// Individual Day Cell View
    private func dayCellView(for date: Date) -> some View {
        let isSelected = calendarViewModel.isSelected(date)
        let isToday = calendarViewModel.isToday(date)
        let dayNumber = Calendar.current.component(.day, from: date)

        // Fetch country codes that have holidays on this date from active selected countries
        let countryCodesWithEvents = HolidayService.shared.countryCodesWithHolidays(
            on: date,
            activeCountryCodes: countryViewModel.selectedCountryCodes
        )

        return Button(action: {
            calendarViewModel.selectDate(date)
        }) {
            VStack(spacing: 2) {
                Text("\(dayNumber)")
                    .font(.system(size: 16, weight: isSelected || isToday ? .bold : .regular))
                    .foregroundStyle(
                        isSelected ? .white : (isToday ? .blue : .primary)
                    )
                    .frame(width: 32, height: 32)
                    .background(
                        ZStack {
                            if isSelected {
                                Circle().fill(Color.blue)
                            } else if isToday {
                                Circle().stroke(Color.blue, lineWidth: 2)
                            }
                        }
                    )

                // Country Flag Indicators for Holidays on this date
                HStack(spacing: 1) {
                    ForEach(Array(countryCodesWithEvents).sorted(), id: \.self) { code in
                        if let country = countryViewModel.countries.first(where: { $0.code == code }) {
                            Text(country.flag)
                                .font(.system(size: 8))
                        }
                    }
                }
                .frame(height: 10)
            }
            .frame(height: 48)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }

    /// Selected Countries Bar showing active filters
    private var selectedCountriesBar: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Selected Countries")
                .font(.caption)
                .fontWeight(.bold)
                .foregroundStyle(.secondary)

            if countryViewModel.selectedCountries.isEmpty {
                Text("No country selected. Go to Settings > Countries to enable.")
                    .font(.caption)
                    .foregroundStyle(.red)
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(countryViewModel.selectedCountries) { country in
                            HStack(spacing: 4) {
                                Text(country.flag)
                                Text(country.name)
                                    .font(.caption)
                                    .fontWeight(.medium)
                            }
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .background(Color.blue.opacity(0.1))
                            .foregroundStyle(.blue)
                            .clipShape(Capsule())
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    /// Event Feed List for Selected Date
    private var selectedDateEventsFeed: some View {
        let holidays = HolidayService.shared.getHolidays(
            on: calendarViewModel.selectedDate,
            countryCodes: countryViewModel.selectedCountryCodes
        )

        return VStack(alignment: .leading, spacing: 12) {
            Text(calendarViewModel.selectedDateTitle)
                .font(.headline)
                .padding(.top, 4)

            if holidays.isEmpty {
                VStack(spacing: 8) {
                    Image(systemName: "calendar.badge.clock")
                        .font(.largeTitle)
                        .foregroundStyle(.tertiary)
                    Text("No holidays or events for selected date")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 24)
                .background(Color(.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 12))
            } else {
                ForEach(holidays) { holiday in
                    NavigationLink(destination: HolidayDetailView(holiday: holiday)) {
                        HolidayEventCard(holiday: holiday)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
}

/// Holiday Event Card Component
struct HolidayEventCard: View {
    let holiday: Holiday

    private var country: Country? {
        Country.defaultCountries.first { $0.code == holiday.countryCode }
    }

    var body: some View {
        HStack(spacing: 12) {
            Text(country?.flag ?? "🏳️")
                .font(.title)

            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(country?.name ?? holiday.countryCode)
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundStyle(.secondary)

                    Spacer()

                    HolidayTypeBadge(type: holiday.type)
                }

                Text(holiday.name)
                    .font(.body)
                    .fontWeight(.semibold)
                    .foregroundStyle(.primary)

                if !holiday.localName.isEmpty && holiday.localName != holiday.name {
                    Text(holiday.localName)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }

            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundStyle(.tertiary)
        }
        .padding(12)
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    CalendarView()
        .environment(CountryViewModel())
}

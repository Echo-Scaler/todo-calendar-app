import SwiftUI
import SwiftData

/// CalendarView
/// Main Calendar View integrating Holidays, Festivals, Todos, and Memos in one unified experience
struct CalendarView: View {
    @Environment(CountryViewModel.self) private var countryViewModel
    @Environment(\.modelContext) private var modelContext
    @State private var calendarViewModel = CalendarViewModel()

    // SwiftData Queries
    @Query(sort: \TodoItem.dueDate) private var todos: [TodoItem]
    @Query(sort: \MemoItem.updatedAt, order: .reverse) private var memos: [MemoItem]

    private let weekdaySymbols = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    private let gridColumns = Array(repeating: GridItem(.flexible(), spacing: 4), count: 7)

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    // MARK: 1. Month Header Navigation
                    monthHeaderView

                    // MARK: 2. Weekday Column Headers
                    weekdayHeaderView

                    // MARK: 3. Monthly Days Grid
                    daysGridView

                    Divider()
                        .padding(.vertical, 4)

                    // MARK: 4. Selected Countries Filter Chips Bar
                    selectedCountriesBar

                    // MARK: 5. Unified Selected Date Events Feed
                    selectedDateUnifiedFeed
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
                    Color.clear
                        .frame(height: 48)
                }
            }
        }
    }

    /// Individual Day Cell View with Holiday Flags, Todo Checkmark Indicator, and Memo Icon
    private func dayCellView(for date: Date) -> some View {
        let isSelected = calendarViewModel.isSelected(date)
        let isToday = calendarViewModel.isToday(date)
        let dayNumber = Calendar.current.component(.day, from: date)

        // Indicators Check
        let countryCodesWithEvents = HolidayService.shared.countryCodesWithHolidays(
            on: date,
            activeCountryCodes: countryViewModel.selectedCountryCodes
        )
        let hasTodoOnDate = todos.contains { todo in
            if let dueDate = todo.dueDate {
                return Calendar.current.isDate(dueDate, inSameDayAs: date)
            }
            return false
        }
        let hasMemoOnDate = memos.contains { memo in
            Calendar.current.isDate(memo.updatedAt, inSameDayAs: date) ||
            Calendar.current.isDate(memo.createdAt, inSameDayAs: date)
        }

        return Button(action: {
            calendarViewModel.selectDate(date)
        }) {
            VStack(spacing: 2) {
                Text("\(dayNumber)")
                    .font(.system(size: 16, weight: isSelected || isToday ? .bold : .regular))
                    .foregroundStyle(
                        isSelected ? .white : (isToday ? .blue : .primary)
                    )
                    .frame(width: 30, height: 30)
                    .background(
                        ZStack {
                            if isSelected {
                                Circle().fill(Color.blue)
                            } else if isToday {
                                Circle().stroke(Color.blue, lineWidth: 2)
                            }
                        }
                    )

                // Event Badges / Indicators Row
                HStack(spacing: 2) {
                    // Holiday Flags
                    ForEach(Array(countryCodesWithEvents).sorted(), id: \.self) { code in
                        if let country = countryViewModel.countries.first(where: { $0.code == code }) {
                            Text(country.flag)
                                .font(.system(size: 8))
                        }
                    }

                    // Todo Checkmark Badge
                    if hasTodoOnDate {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 8))
                            .foregroundStyle(isSelected ? .white : .green)
                    }

                    // Memo Icon Badge
                    if hasMemoOnDate {
                        Image(systemName: "note.text")
                            .font(.system(size: 8))
                            .foregroundStyle(isSelected ? .white : .orange)
                    }
                }
                .frame(height: 10)
            }
            .frame(height: 48)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }

    /// Active Selected Countries Filter Chips Bar
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

    /// Unified Feed for Selected Date
    private var selectedDateUnifiedFeed: some View {
        let holidays = HolidayService.shared.getHolidays(
            on: calendarViewModel.selectedDate,
            countryCodes: countryViewModel.selectedCountryCodes
        )
        let selectedTodos = todos.filter { todo in
            if let dueDate = todo.dueDate {
                return Calendar.current.isDate(dueDate, inSameDayAs: calendarViewModel.selectedDate)
            }
            return false
        }
        let selectedMemos = memos.filter { memo in
            Calendar.current.isDate(memo.updatedAt, inSameDayAs: calendarViewModel.selectedDate) ||
            Calendar.current.isDate(memo.createdAt, inSameDayAs: calendarViewModel.selectedDate)
        }

        let isEmptyFeed = holidays.isEmpty && selectedTodos.isEmpty && selectedMemos.isEmpty

        return VStack(alignment: .leading, spacing: 16) {
            Text(calendarViewModel.selectedDateTitle)
                .font(.headline)
                .padding(.top, 4)

            if isEmptyFeed {
                VStack(spacing: 8) {
                    Image(systemName: "calendar.badge.clock")
                        .font(.largeTitle)
                        .foregroundStyle(.tertiary)
                    Text("No events, todos, or notes for selected date")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 24)
                .background(Color(.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 12))
            } else {
                // Section 1: Holidays
                if !holidays.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        Label("Holidays & Observances", systemImage: "flag.fill")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundStyle(.secondary)

                        ForEach(holidays) { holiday in
                            NavigationLink(destination: HolidayDetailView(holiday: holiday)) {
                                HolidayEventCard(holiday: holiday)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }

                // Section 2: Todos
                if !selectedTodos.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        Label("Tasks Due Today", systemImage: "checkmark.circle.fill")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundStyle(.secondary)

                        ForEach(selectedTodos) { todo in
                            TodoRowView(todo: todo) {}
                                .padding(12)
                                .background(Color(.secondarySystemBackground))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                    }
                }

                // Section 3: Memos
                if !selectedMemos.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        Label("Notes & Memos", systemImage: "note.text")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundStyle(.secondary)

                        ForEach(selectedMemos) { memo in
                            MemoRowView(memo: memo) {}
                                .padding(12)
                                .background(Color(.secondarySystemBackground))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    CalendarView()
        .environment(CountryViewModel())
        .modelContainer(for: [TodoItem.self, MemoItem.self], inMemory: true)
}

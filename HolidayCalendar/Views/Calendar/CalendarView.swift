import SwiftUI

/// CalendarView
/// Rule 8.4: Accesses shared CountryViewModel instance from environment
struct CalendarView: View {
    @Environment(CountryViewModel.self) private var countryViewModel

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Text("Calendar Screen")
                    .font(.title2)
                    .foregroundStyle(.secondary)

                // Display selected country flags badge count
                HStack(spacing: 8) {
                    Text("Active Countries:")
                        .font(.caption)
                        .foregroundStyle(.secondary)

                    ForEach(countryViewModel.selectedCountries) { country in
                        Text(country.flag)
                            .font(.title3)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color(.secondarySystemBackground))
                .clipShape(Capsule())
            }
            .navigationTitle("Calendar")
        }
    }
}

#Preview {
    CalendarView()
        .environment(CountryViewModel())
}

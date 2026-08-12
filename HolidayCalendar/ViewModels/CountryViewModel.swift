import Foundation
import Observation

/// CountryViewModel
/// Rule 5.1: @Observable macro (iOS 17+)
/// Rule 5.2: Single source of truth for country selection state
@Observable
final class CountryViewModel {
    // Rule 5.3: All available countries
    private(set) var countries: [Country]

    // Rule 5.3: Persisted selected country codes
    private var selectedCodesStorage: Set<String> {
        didSet {
            saveSelectedCodes()
        }
    }

    private let storageKey = "selectedCountryCodes"

    init(countries: [Country] = Country.defaultCountries) {
        self.countries = countries
        self.selectedCodesStorage = []
        // Rule 5.7: load persisted selection on init
        self.selectedCodesStorage = loadSelectedCodes()
    }

    // Rule 5.4: Computed properties
    var countriesWithSelection: [Country] {
        countries.map { country in
            var updated = country
            updated.isSelected = selectedCodesStorage.contains(country.code)
            return updated
        }
    }

    var selectedCountries: [Country] {
        countriesWithSelection.filter { $0.isSelected }
    }

    var selectedCountryCodes: Set<String> {
        selectedCodesStorage
    }

    // Rule 5.5 & 5.6: Actions with immediate UI update
    func toggleCountry(_ country: Country) {
        if selectedCodesStorage.contains(country.code) {
            selectedCodesStorage.remove(country.code)
        } else {
            selectedCodesStorage.insert(country.code)
        }
    }

    func selectAll() {
        selectedCodesStorage = Set(countries.map { $0.code })
    }

    func clearAll() {
        selectedCodesStorage.removeAll()
    }

    // Rule 5.7, 7.3, 7.4: Persistence Logic using UserDefaults
    private func loadSelectedCodes() -> Set<String> {
        guard let data = UserDefaults.standard.data(forKey: storageKey),
              let codes = try? JSONDecoder().decode(Set<String>.self, from: data) else {
            // Rule 5.8 & 7.4: Default selection on first launch
            return ["JP", "MM", "TH"]
        }
        return codes
    }

    private func saveSelectedCodes() {
        if let data = try? JSONEncoder().encode(selectedCodesStorage) {
            UserDefaults.standard.set(data, forKey: storageKey)
        }
    }
}

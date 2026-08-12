import Foundation

/// Holiday Type Enum (Rule 12 in specification)
enum HolidayType: String, Codable, CaseIterable {
    case publicHoliday
    case governmentHoliday
    case festival
    case observance
    case religious
    case cultural
}

/// Holiday Data Model (Placeholder for Phase 4)
struct Holiday: Identifiable, Codable, Hashable {
    let id: String
    let countryCode: String
    let name: String
    let localName: String
    let date: Date
    let type: HolidayType
    let description: String
    let isPublicHoliday: Bool
}

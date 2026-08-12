import Foundation

/// Country Data Model
/// Rule 4.1: struct Country — Identifiable, Codable, Hashable (no @Model for Country)
/// Rule 4.2: Required properties included
/// Rule 4.3: Country code used as primary identifier
struct Country: Identifiable, Codable, Hashable {
    var id: String { code }
    let code: String        // ISO 3166-1 alpha-2 (e.g. JP, MM, AU, KR, TH)
    let name: String        // English name
    let localName: String   // Local language name
    let flag: String        // Emoji flag
    var isSelected: Bool    // Selection state
    let timezone: String    // Primary timezone
}

extension Country {
    /// Rule 4.4 & 4.5: Initial Five Countries
    /// Initial Selection: JP (true), MM (true), AU (false), KR (false - South Korea), TH (true)
    static let defaultCountries: [Country] = [
        Country(
            code: "JP",
            name: "Japan",
            localName: "日本",
            flag: "🇯🇵",
            isSelected: true,
            timezone: "Asia/Tokyo"
        ),
        Country(
            code: "MM",
            name: "Myanmar",
            localName: "မြန်မာ",
            flag: "🇲🇲",
            isSelected: true,
            timezone: "Asia/Yangon"
        ),
        Country(
            code: "AU",
            name: "Australia",
            localName: "Australia",
            flag: "🇦🇺",
            isSelected: false,
            timezone: "Australia/Sydney"
        ),
        Country(
            code: "KR",
            name: "Korea",
            localName: "대한민국",
            flag: "🇰🇷",
            isSelected: false,
            timezone: "Asia/Seoul"
        ),
        Country(
            code: "TH",
            name: "Thailand",
            localName: "ประเทศไทย",
            flag: "🇹🇭",
            isSelected: true,
            timezone: "Asia/Bangkok"
        )
    ]
}

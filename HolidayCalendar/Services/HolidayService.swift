import Foundation

/// HolidayService
/// Provides local dummy holiday data for the 5 initial countries (JP, MM, AU, KR, TH)
final class HolidayService {
    static let shared = HolidayService()

    private let calendar = Calendar.current

    private init() {}

    /// Fetches all dummy holidays filtered by the provided selected country codes.
    func getHolidays(for countryCodes: Set<String>) -> [Holiday] {
        return allDummyHolidays.filter { countryCodes.contains($0.countryCode) }
    }

    /// Fetches holidays for a specific date filtered by selected country codes.
    func getHolidays(on date: Date, countryCodes: Set<String>) -> [Holiday] {
        return getHolidays(for: countryCodes).filter { calendar.isDate($0.date, inSameDayAs: date) }
    }

    /// Checks if a date has any holidays for the selected country codes.
    func hasHolidays(on date: Date, countryCodes: Set<String>) -> Bool {
        return !getHolidays(on: date, countryCodes: countryCodes).isEmpty
    }

    /// Returns a set of country codes that have holidays on the specified date.
    func countryCodesWithHolidays(on date: Date, activeCountryCodes: Set<String>) -> Set<String> {
        let holidays = getHolidays(on: date, countryCodes: activeCountryCodes)
        return Set(holidays.map { $0.countryCode })
    }

    // MARK: - Dummy Data Generation

    private var allDummyHolidays: [Holiday] {
        return japanHolidays + myanmarHolidays + australiaHolidays + koreaHolidays + thailandHolidays
    }

    private func makeDate(year: Int, month: Int, day: Int) -> Date {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        return calendar.date(from: components) ?? Date()
    }

    // MARK: 🇯🇵 Japan Holidays
    private var japanHolidays: [Holiday] {
        [
            Holiday(
                id: "JP-2026-01-01",
                countryCode: "JP",
                name: "New Year's Day",
                localName: "元日 (Ganjitsu)",
                date: makeDate(year: 2026, month: 1, day: 1),
                type: .publicHoliday,
                description: "National holiday celebrating the start of the new year.",
                isPublicHoliday: true
            ),
            Holiday(
                id: "JP-2026-02-11",
                countryCode: "JP",
                name: "National Foundation Day",
                localName: "建国記念の日 (Kenkoku Kinen no Hi)",
                date: makeDate(year: 2026, month: 2, day: 11),
                type: .publicHoliday,
                description: "Reflecting on the establishment of the nation and fostering patriotism.",
                isPublicHoliday: true
            ),
            Holiday(
                id: "JP-2026-03-20",
                countryCode: "JP",
                name: "Vernal Equinox Day",
                localName: "春分の日 (Shunbun no Hi)",
                date: makeDate(year: 2026, month: 3, day: 20),
                type: .publicHoliday,
                description: "Day to appreciate nature and cherish all living things.",
                isPublicHoliday: true
            ),
            Holiday(
                id: "JP-2026-05-03",
                countryCode: "JP",
                name: "Constitution Memorial Day",
                localName: "憲法記念日 (Kenpō Kinenbi)",
                date: makeDate(year: 2026, month: 5, day: 3),
                type: .publicHoliday,
                description: "Commemorating the enforcement of the 1947 Constitution of Japan.",
                isPublicHoliday: true
            ),
            Holiday(
                id: "JP-2026-05-05",
                countryCode: "JP",
                name: "Children's Day",
                localName: "こどもの日 (Kodomo no Hi)",
                date: makeDate(year: 2026, month: 5, day: 5),
                type: .publicHoliday,
                description: "Respecting children's personalities and celebrating their happiness.",
                isPublicHoliday: true
            ),
            Holiday(
                id: "JP-2026-08-11",
                countryCode: "JP",
                name: "Mountain Day",
                localName: "山の日 (Yama no Hi)",
                date: makeDate(year: 2026, month: 8, day: 11),
                type: .publicHoliday,
                description: "Providing opportunities to become familiar with mountains and appreciate blessings from mountains.",
                isPublicHoliday: true
            ),
            Holiday(
                id: "JP-2026-09-21",
                countryCode: "JP",
                name: "Respect for the Aged Day",
                localName: "敬老の日 (Keirō no Hi)",
                date: makeDate(year: 2026, month: 9, day: 21),
                type: .publicHoliday,
                description: "Honoring elderly citizens and celebrating longevity.",
                isPublicHoliday: true
            ),
            Holiday(
                id: "JP-2026-11-03",
                countryCode: "JP",
                name: "Culture Day",
                localName: "文化の日 (Bunka no Hi)",
                date: makeDate(year: 2026, month: 11, day: 3),
                type: .cultural,
                description: "Promoting culture, the arts, and academic endeavor.",
                isPublicHoliday: true
            )
        ]
    }

    // MARK: 🇲🇲 Myanmar Holidays
    private var myanmarHolidays: [Holiday] {
        [
            Holiday(
                id: "MM-2026-01-04",
                countryCode: "MM",
                name: "Independence Day",
                localName: "လွတ်လပ်ရေးနေ့ (Independence Day)",
                date: makeDate(year: 2026, month: 1, day: 4),
                type: .publicHoliday,
                description: "Commemorating Myanmar's declaration of independence in 1948.",
                isPublicHoliday: true
            ),
            Holiday(
                id: "MM-2026-02-12",
                countryCode: "MM",
                name: "Union Day",
                localName: "ပြည်ထောင်စုနေ့ (Union Day)",
                date: makeDate(year: 2026, month: 2, day: 12),
                type: .publicHoliday,
                description: "Honoring the Panglong Agreement signed in 1947.",
                isPublicHoliday: true
            ),
            Holiday(
                id: "MM-2026-03-27",
                countryCode: "MM",
                name: "Armed Forces Day",
                localName: "တော်လှန်ရေးနေ့ (Armed Forces Day)",
                date: makeDate(year: 2026, month: 3, day: 27),
                type: .governmentHoliday,
                description: "Commemorating the start of resistance against foreign occupation in 1945.",
                isPublicHoliday: true
            ),
            Holiday(
                id: "MM-2026-04-13",
                countryCode: "MM",
                name: "Maha Thingyan Water Festival - Day 1",
                localName: "သင်္ကြန်အကြိုနေ့ (Thingyan Akyo Day)",
                date: makeDate(year: 2026, month: 4, day: 13),
                type: .festival,
                description: "Traditional Myanmar Water Festival celebrating the New Year.",
                isPublicHoliday: true
            ),
            Holiday(
                id: "MM-2026-04-14",
                countryCode: "MM",
                name: "Maha Thingyan Water Festival - Day 2",
                localName: "သင်္ကြန်အကျနေ့ (Thingyan Akya Day)",
                date: makeDate(year: 2026, month: 4, day: 14),
                type: .festival,
                description: "Festive water throwing across the nation to cleanse bad luck.",
                isPublicHoliday: true
            ),
            Holiday(
                id: "MM-2026-04-17",
                countryCode: "MM",
                name: "Myanmar New Year's Day",
                localName: "မြန်မာနှစ်ဆန်းတစ်ရက်နေ့ (Myanmar New Year)",
                date: makeDate(year: 2026, month: 4, day: 17),
                type: .publicHoliday,
                description: "First day of the Myanmar traditional lunar calendar.",
                isPublicHoliday: true
            ),
            Holiday(
                id: "MM-2026-07-19",
                countryCode: "MM",
                name: "Martyrs' Day",
                localName: "အာဇာနည်နေ့ (Martyrs' Day)",
                date: makeDate(year: 2026, month: 7, day: 19),
                type: .publicHoliday,
                description: "Commemorating General Aung San and fallen leaders assassinated in 1947.",
                isPublicHoliday: true
            ),
            Holiday(
                id: "MM-2026-08-12",
                countryCode: "MM",
                name: "Full Moon of Wagaung / Metta Day",
                localName: "ဝါခေါင်လပြည့် မေတ္တာအခါတော်နေ့",
                date: makeDate(year: 2026, month: 8, day: 12),
                type: .religious,
                description: "Traditional Buddhist observance day promoting loving-kindness.",
                isPublicHoliday: false
            ),
            Holiday(
                id: "MM-2026-11-24",
                countryCode: "MM",
                name: "Full Moon of Tazaungmon",
                localName: "တန်ဆောင်တိုင်လပြည့်နေ့ (Tazaungdaing Festival)",
                date: makeDate(year: 2026, month: 11, day: 24),
                type: .festival,
                description: "Festival of lights featuring hot air balloons and robe weaving.",
                isPublicHoliday: true
            )
        ]
    }

    // MARK: 🇦🇺 Australia Holidays
    private var australiaHolidays: [Holiday] {
        [
            Holiday(
                id: "AU-2026-01-01",
                countryCode: "AU",
                name: "New Year's Day",
                localName: "New Year's Day",
                date: makeDate(year: 2026, month: 1, day: 1),
                type: .publicHoliday,
                description: "First day of the calendar year.",
                isPublicHoliday: true
            ),
            Holiday(
                id: "AU-2026-01-26",
                countryCode: "AU",
                name: "Australia Day",
                localName: "Australia Day",
                date: makeDate(year: 2026, month: 1, day: 26),
                type: .publicHoliday,
                description: "Official national day of Australia.",
                isPublicHoliday: true
            ),
            Holiday(
                id: "AU-2026-04-25",
                countryCode: "AU",
                name: "ANZAC Day",
                localName: "ANZAC Day",
                date: makeDate(year: 2026, month: 4, day: 25),
                type: .observance,
                description: "Commemorating Australians and New Zealanders who served in military conflicts.",
                isPublicHoliday: true
            ),
            Holiday(
                id: "AU-2026-06-08",
                countryCode: "AU",
                name: "King's Birthday",
                localName: "King's Birthday",
                date: makeDate(year: 2026, month: 6, day: 8),
                type: .governmentHoliday,
                description: "Official birthday of King Charles III celebrated across most states.",
                isPublicHoliday: true
            ),
            Holiday(
                id: "AU-2026-08-12",
                countryCode: "AU",
                name: "Royal Queensland Show Day (Ekka)",
                localName: "Ekka Wednesday",
                date: makeDate(year: 2026, month: 8, day: 12),
                type: .cultural,
                description: "Popular agricultural show holiday celebrated in Brisbane.",
                isPublicHoliday: false
            ),
            Holiday(
                id: "AU-2026-12-25",
                countryCode: "AU",
                name: "Christmas Day",
                localName: "Christmas Day",
                date: makeDate(year: 2026, month: 12, day: 25),
                type: .publicHoliday,
                description: "Annual Christian holiday commemorating the birth of Jesus Christ.",
                isPublicHoliday: true
            )
        ]
    }

    // MARK: 🇰🇷 Korea Holidays (South Korea)
    private var koreaHolidays: [Holiday] {
        [
            Holiday(
                id: "KR-2026-01-01",
                countryCode: "KR",
                name: "New Year's Day",
                localName: "신정 (Sinjeong)",
                date: makeDate(year: 2026, month: 1, day: 1),
                type: .publicHoliday,
                description: "Solar New Year's Day celebration.",
                isPublicHoliday: true
            ),
            Holiday(
                id: "KR-2026-03-01",
                countryCode: "KR",
                name: "Independence Movement Day",
                localName: "삼일절 (Samiljeol)",
                date: makeDate(year: 2026, month: 3, day: 1),
                type: .publicHoliday,
                description: "Commemorating the 1919 March 1st Movement against Japanese rule.",
                isPublicHoliday: true
            ),
            Holiday(
                id: "KR-2026-05-05",
                countryCode: "KR",
                name: "Children's Day",
                localName: "어린이날 (Eorininal)",
                date: makeDate(year: 2026, month: 5, day: 5),
                type: .publicHoliday,
                description: "Day honoring children and promoting family bonding.",
                isPublicHoliday: true
            ),
            Holiday(
                id: "KR-2026-08-12",
                countryCode: "KR",
                name: "International Youth Day Observance",
                localName: "청소년의 날",
                date: makeDate(year: 2026, month: 8, day: 12),
                type: .observance,
                description: "Observance encouraging youth cultural activities.",
                isPublicHoliday: false
            ),
            Holiday(
                id: "KR-2026-08-15",
                countryCode: "KR",
                name: "National Liberation Day",
                localName: "광복절 (Gwangbokjeol)",
                date: makeDate(year: 2026, month: 8, day: 15),
                type: .publicHoliday,
                description: "Celebrating liberation from Japanese occupation in 1945 and foundation of Republic of Korea.",
                isPublicHoliday: true
            ),
            Holiday(
                id: "KR-2026-09-25",
                countryCode: "KR",
                name: "Chuseok (Harvest Festival)",
                localName: "추석 (Chuseok)",
                date: makeDate(year: 2026, month: 9, day: 25),
                type: .festival,
                description: "Major mid-autumn harvest festival where families gather and honor ancestors.",
                isPublicHoliday: true
            ),
            Holiday(
                id: "KR-2026-10-09",
                countryCode: "KR",
                name: "Hangul Proclamation Day",
                localName: "한글날 (Hangeulnal)",
                date: makeDate(year: 2026, month: 10, day: 9),
                type: .cultural,
                description: "Commemorating the invention and proclamation of the Korean alphabet (Hangul) by King Sejong.",
                isPublicHoliday: true
            )
        ]
    }

    // MARK: 🇹🇭 Thailand Holidays
    private var thailandHolidays: [Holiday] {
        [
            Holiday(
                id: "TH-2026-01-01",
                countryCode: "TH",
                name: "New Year's Day",
                localName: "วันขึ้นปีใหม่ (Wan Khuen Pi Mai)",
                date: makeDate(year: 2026, month: 1, day: 1),
                type: .publicHoliday,
                description: "First day of the Western calendar year.",
                isPublicHoliday: true
            ),
            Holiday(
                id: "TH-2026-04-13",
                countryCode: "TH",
                name: "Songkran Water Festival",
                localName: "วันสงกรานต์ (Songkran Festival)",
                date: makeDate(year: 2026, month: 4, day: 13),
                type: .festival,
                description: "Traditional Thai New Year celebrated with water splashing, merit making, and family reunions.",
                isPublicHoliday: true
            ),
            Holiday(
                id: "TH-2026-07-28",
                countryCode: "TH",
                name: "King Vajiralongkorn's Birthday",
                localName: "วันเฉลิมพระชนมพรรษา (King's Birthday)",
                date: makeDate(year: 2026, month: 7, day: 28),
                type: .publicHoliday,
                description: "Celebrating the birthday of His Majesty King Rama X.",
                isPublicHoliday: true
            ),
            Holiday(
                id: "TH-2026-08-12",
                countryCode: "TH",
                name: "Queen Sirikit's Birthday / Mother's Day",
                localName: "วันแม่แห่งชาติ (Wan Mae Haeng Chat)",
                date: makeDate(year: 2026, month: 8, day: 12),
                type: .publicHoliday,
                description: "Celebrating Her Majesty Queen Sirikit The Queen Mother's birthday and Mother's Day across Thailand.",
                isPublicHoliday: true
            ),
            Holiday(
                id: "TH-2026-10-13",
                countryCode: "TH",
                name: "King Bhumibol Adulyadej Memorial Day",
                localName: "วันคล้ายวันสวรรคတ ร.၉",
                date: makeDate(year: 2026, month: 10, day: 13),
                type: .observance,
                description: "Commemorating the passing of the late King Rama IX.",
                isPublicHoliday: true
            ),
            Holiday(
                id: "TH-2026-12-10",
                countryCode: "TH",
                name: "Constitution Day",
                localName: "วันรัฐธรรมนูญ (Wan Rattha Thammanun)",
                date: makeDate(year: 2026, month: 12, day: 10),
                type: .governmentHoliday,
                description: "Commemorating Thailand's transition to a constitutional monarchy in 1932.",
                isPublicHoliday: true
            )
        ]
    }
}

import SwiftUI

/// HolidayDetailView
/// Rule 13: Display Holiday detail with Name, Flag, Country, Date, Type Badge, and Description
struct HolidayDetailView: View {
    let holiday: Holiday

    private var country: Country? {
        Country.defaultCountries.first { $0.code == holiday.countryCode }
    }

    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter.string(from: holiday.date)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Header Card: Flag + Country Name + Local Name
                HStack(spacing: 16) {
                    Text(country?.flag ?? "🏳️")
                        .font(.system(size: 54))

                    VStack(alignment: .leading, spacing: 4) {
                        Text(country?.name ?? holiday.countryCode)
                            .font(.title2)
                            .fontWeight(.bold)

                        if let localName = country?.localName, !localName.isEmpty {
                            Text(localName)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }

                    Spacer()

                    // Type Badge
                    HolidayTypeBadge(type: holiday.type)
                }
                .padding()
                .background(Color(.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 16))

                // Title & Date Section
                VStack(alignment: .leading, spacing: 8) {
                    Text(holiday.name)
                        .font(.title)
                        .fontWeight(.bold)

                    if !holiday.localName.isEmpty && holiday.localName != holiday.name {
                        Text(holiday.localName)
                            .font(.title3)
                            .foregroundStyle(.secondary)
                    }

                    HStack(spacing: 6) {
                        Image(systemName: "calendar")
                            .foregroundStyle(.blue)
                        Text(formattedDate)
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.top, 4)
                }
                .padding(.horizontal, 4)

                Divider()

                // Description Card
                VStack(alignment: .leading, spacing: 10) {
                    Text("Description")
                        .font(.headline)

                    Text(holiday.description.isEmpty ? "No detailed description available." : holiday.description)
                        .font(.body)
                        .foregroundStyle(.secondary)
                        .lineSpacing(4)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(.tertiarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 12))

                Spacer()
            }
            .padding()
        }
        .navigationTitle("Holiday Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

/// Helper Badge View for Holiday Types
struct HolidayTypeBadge: View {
    let type: HolidayType

    var body: some View {
        Text(title)
            .font(.caption)
            .fontWeight(.semibold)
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(backgroundColor)
            .foregroundStyle(foregroundColor)
            .clipShape(Capsule())
    }

    private var title: String {
        switch type {
        case .publicHoliday: return "Public Holiday"
        case .governmentHoliday: return "Gov Holiday"
        case .festival: return "Festival"
        case .observance: return "Observance"
        case .religious: return "Religious"
        case .cultural: return "Cultural"
        }
    }

    private var backgroundColor: Color {
        switch type {
        case .publicHoliday: return Color.red.opacity(0.15)
        case .governmentHoliday: return Color.purple.opacity(0.15)
        case .festival: return Color.orange.opacity(0.15)
        case .observance: return Color.blue.opacity(0.15)
        case .religious: return Color.green.opacity(0.15)
        case .cultural: return Color.pink.opacity(0.15)
        }
    }

    private var foregroundColor: Color {
        switch type {
        case .publicHoliday: return .red
        case .governmentHoliday: return .purple
        case .festival: return .orange
        case .observance: return .blue
        case .religious: return .green
        case .cultural: return .pink
        }
    }
}

#Preview {
    NavigationStack {
        HolidayDetailView(
            holiday: Holiday(
                id: "JP-1",
                countryCode: "JP",
                name: "Mountain Day",
                localName: "山の日",
                date: Date(),
                type: .publicHoliday,
                description: "Providing opportunities to become familiar with mountains and appreciate blessings from nature.",
                isPublicHoliday: true
            )
        )
    }
}

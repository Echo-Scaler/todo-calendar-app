import SwiftUI

/// CountrySelectionView
/// Rule 6.1: @Environment(CountryViewModel.self) access
/// Rule 6.7: .navigationTitle("Countries")
struct CountrySelectionView: View {
    @Environment(CountryViewModel.self) private var viewModel

    var body: some View {
        List {
            // Rule 6.2 & 6.3: Section 1 - Select All / Clear All buttons (visually clean, secondary)
            Section {
                HStack {
                    Button(action: {
                        viewModel.selectAll()
                    }) {
                        Text("Select All")
                            .font(.subheadline)
                    }
                    .buttonStyle(.borderless)

                    Spacer()

                    Divider()

                    Spacer()

                    Button(action: {
                        viewModel.clearAll()
                    }) {
                        Text("Clear All")
                            .font(.subheadline)
                            .foregroundStyle(.red)
                    }
                    .buttonStyle(.borderless)
                }
                .padding(.vertical, 4)
            }

            // Rule 6.2: Section 2 - Country list
            Section("Countries") {
                ForEach(viewModel.countriesWithSelection) { country in
                    CountryRow(country: country) {
                        viewModel.toggleCountry(country)
                    }
                }
            }
        }
        .navigationTitle("Countries")
    }
}

/// Country Row View
/// Rule 6.4: Emoji flag (.title2), Country name, Native SwiftUI Toggle
/// Rule 6.5: Entire row tap gesture with .contentShape(Rectangle())
/// Rule 6.6: Native SwiftUI Toggle control
struct CountryRow: View {
    let country: Country
    let onToggle: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            Text(country.flag)
                .font(.title2)

            VStack(alignment: .leading, spacing: 2) {
                Text(country.name)
                    .font(.body)
                    .fontWeight(.medium)

                Text(country.localName)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Toggle("", isOn: Binding(
                get: { country.isSelected },
                set: { _ in onToggle() }
            ))
            .labelsHidden()
        }
        .contentShape(Rectangle())
        .onTapGesture {
            onToggle()
        }
    }
}

#Preview {
    NavigationStack {
        CountrySelectionView()
            .environment(CountryViewModel())
    }
}

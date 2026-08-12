import SwiftUI

/// CountrySelectionView placeholder
/// Rule 6.7: .navigationTitle("Countries") set လုပ်ရမယ် (Step 6 မှာ တကယ့် UI ထည့်ပါမည်)
struct CountrySelectionView: View {
    var body: some View {
        VStack {
            Text("Country Selection Placeholder")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .navigationTitle("Countries")
    }
}

#Preview {
    NavigationStack {
        CountrySelectionView()
    }
}

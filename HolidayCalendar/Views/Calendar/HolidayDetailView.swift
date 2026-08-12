import SwiftUI

/// HolidayDetailView placeholder
/// Rule 3.5: Empty placeholder view
struct HolidayDetailView: View {
    var body: some View {
        VStack {
            Text("Holiday Detail Placeholder")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .navigationTitle("Holiday Detail")
    }
}

#Preview {
    HolidayDetailView()
}

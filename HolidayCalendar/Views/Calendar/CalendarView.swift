import SwiftUI

/// CalendarView placeholder
/// Rule 3.2: NavigationStack နဲ့ .navigationTitle() ပါဝင်ရမည်
struct CalendarView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Calendar Screen")
                    .font(.title2)
                    .foregroundStyle(.secondary)
            }
            .navigationTitle("Calendar")
        }
    }
}

#Preview {
    CalendarView()
}

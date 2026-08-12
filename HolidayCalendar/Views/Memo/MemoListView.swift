import SwiftUI

/// MemoListView placeholder
/// Rule 3.2: NavigationStack နဲ့ .navigationTitle() ပါဝင်ရမည်
struct MemoListView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Memo Screen")
                    .font(.title2)
                    .foregroundStyle(.secondary)
            }
            .navigationTitle("Memo")
        }
    }
}

#Preview {
    MemoListView()
}

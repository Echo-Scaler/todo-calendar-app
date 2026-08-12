import SwiftUI

/// TodoListView placeholder
/// Rule 3.2: NavigationStack နဲ့ .navigationTitle() ပါဝင်ရမည်
struct TodoListView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Todo Screen")
                    .font(.title2)
                    .foregroundStyle(.secondary)
            }
            .navigationTitle("Todo")
        }
    }
}

#Preview {
    TodoListView()
}

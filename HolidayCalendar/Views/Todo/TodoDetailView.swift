import SwiftUI

/// TodoDetailView placeholder
/// Rule 3.5: Empty placeholder view
struct TodoDetailView: View {
    var body: some View {
        VStack {
            Text("Todo Detail Placeholder")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .navigationTitle("Todo Detail")
    }
}

#Preview {
    TodoDetailView()
}

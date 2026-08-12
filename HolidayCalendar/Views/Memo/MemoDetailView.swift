import SwiftUI

/// MemoDetailView placeholder
/// Rule 3.5: Empty placeholder view
struct MemoDetailView: View {
    var body: some View {
        VStack {
            Text("Memo Detail Placeholder")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .navigationTitle("Memo Detail")
    }
}

#Preview {
    MemoDetailView()
}

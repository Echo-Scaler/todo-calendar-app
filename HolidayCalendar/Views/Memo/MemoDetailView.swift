import SwiftUI
import SwiftData

/// MemoDetailView
/// Full-screen sheet/view for creating or editing MemoItem content
struct MemoDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    var memoToEdit: MemoItem?

    @State private var title: String = ""
    @State private var content: String = ""

    private var isEditing: Bool {
        memoToEdit != nil
    }

    init(memoToEdit: MemoItem? = nil) {
        self.memoToEdit = memoToEdit
        if let memo = memoToEdit {
            _title = State(initialValue: memo.title)
            _content = State(initialValue: memo.content)
        }
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 12) {
                // Title Field
                TextField("Title", text: $title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                    .padding(.top, 8)

                Divider()

                // Content Editor
                TextEditor(text: $content)
                    .font(.body)
                    .padding(.horizontal, 12)

                Spacer()
            }
            .navigationTitle(isEditing ? "Edit Note" : "New Note")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveMemo()
                    }
                    .disabled(title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
    }

    private func saveMemo() {
        let cleanTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanContent = content.trimmingCharacters(in: .whitespacesAndNewlines)

        if let memo = memoToEdit {
            memo.title = cleanTitle
            memo.content = cleanContent
            memo.updatedAt = Date()
        } else {
            let newMemo = MemoItem(
                title: cleanTitle,
                content: cleanContent,
                createdAt: Date(),
                updatedAt: Date()
            )
            modelContext.insert(newMemo)
        }

        dismiss()
    }
}

#Preview {
    MemoDetailView()
}

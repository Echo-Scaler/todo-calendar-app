import SwiftUI
import SwiftData

/// MemoListView
/// Main View displaying Memos/Notes with searching, grid/list layout, and CRUD integration
struct MemoListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \MemoItem.updatedAt, order: .reverse) private var memos: [MemoItem]

    @State private var searchText: String = ""
    @State private var isShowingAddSheet: Bool = false
    @State private var selectedMemoToEdit: MemoItem? = nil

    private var filteredMemos: [MemoItem] {
        if searchText.isEmpty {
            return memos
        } else {
            return memos.filter { memo in
                memo.title.localizedCaseInsensitiveContains(searchText) ||
                memo.content.localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    var body: some View {
        NavigationStack {
            Group {
                if filteredMemos.isEmpty {
                    emptyStateView
                } else {
                    List {
                        ForEach(filteredMemos) { memo in
                            MemoRowView(memo: memo) {
                                selectedMemoToEdit = memo
                            }
                        }
                        .onDelete(perform: deleteMemos)
                    }
                    .listStyle(.insetGrouped)
                }
            }
            .navigationTitle("Memo")
            .searchable(text: $searchText, prompt: "Search notes...")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        isShowingAddSheet = true
                    }) {
                        Image(systemName: "square.and.pencil")
                            .font(.title3)
                    }
                }
            }
            .sheet(isPresented: $isShowingAddSheet) {
                MemoDetailView()
            }
            .sheet(item: $selectedMemoToEdit) { memo in
                MemoDetailView(memoToEdit: memo)
            }
        }
    }

    // Empty State Component
    private var emptyStateView: some View {
        VStack(spacing: 16) {
            Spacer()
            Image(systemName: "note.text.badge.plus")
                .font(.system(size: 56))
                .foregroundStyle(.tertiary)

            Text("No notes found")
                .font(.headline)
                .foregroundStyle(.secondary)

            Button(action: {
                isShowingAddSheet = true
            }) {
                Label("Create New Note", systemImage: "plus")
                    .font(.subheadline)
                    .fontWeight(.semibold)
            }
            .buttonStyle(.borderedProminent)
            Spacer()
        }
        .padding()
    }

    private func deleteMemos(at offsets: IndexSet) {
        for index in offsets {
            let memo = filteredMemos[index]
            modelContext.delete(memo)
        }
    }
}

/// Memo Row Component
struct MemoRowView: View {
    let memo: MemoItem
    let onTapEdit: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(memo.title)
                    .font(.headline)
                    .lineLimit(1)

                Spacer()

                Text(formattedDate(memo.updatedAt))
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }

            if !memo.content.isEmpty {
                Text(memo.content)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }
        }
        .padding(.vertical, 4)
        .contentShape(Rectangle())
        .onTapGesture {
            onTapEdit()
        }
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

#Preview {
    MemoListView()
        .modelContainer(for: MemoItem.self, inMemory: true)
}

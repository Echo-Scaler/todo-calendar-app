import SwiftUI
import SwiftData

enum TodoFilterTab: String, CaseIterable {
    case all = "All"
    case pending = "Pending"
    case completed = "Completed"
}

/// TodoListView
/// Main View displaying Todo tasks with filtering, search, toggle completion, and CRUD actions
struct TodoListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \TodoItem.createdAt, order: .reverse) private var todos: [TodoItem]

    @State private var selectedFilter: TodoFilterTab = .all
    @State private var searchText: String = ""
    @State private var isShowingAddSheet: Bool = false
    @State private var selectedTodoToEdit: TodoItem? = nil

    private var filteredTodos: [TodoItem] {
        todos.filter { todo in
            let matchesFilter: Bool
            switch selectedFilter {
            case .all: matchesFilter = true
            case .pending: matchesFilter = !todo.isCompleted
            case .completed: matchesFilter = todo.isCompleted
            }

            let matchesSearch = searchText.isEmpty || todo.title.localizedCaseInsensitiveContains(searchText)
            return matchesFilter && matchesSearch
        }
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Filter Segmented Picker
                Picker("Filter", selection: $selectedFilter) {
                    ForEach(TodoFilterTab.allCases, id: \.self) { filter in
                        Text(filter.rawValue).tag(filter)
                    }
                }
                .pickerStyle(.segmented)
                .padding()

                // Todo List / Empty State
                if filteredTodos.isEmpty {
                    emptyStateView
                } else {
                    List {
                        ForEach(filteredTodos) { todo in
                            TodoRowView(todo: todo) {
                                selectedTodoToEdit = todo
                            }
                        }
                        .onDelete(perform: deleteTodos)
                    }
                    .listStyle(.insetGrouped)
                }
            }
            .navigationTitle("Todo")
            .searchable(text: $searchText, prompt: "Search tasks...")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        isShowingAddSheet = true
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title3)
                    }
                }
            }
            .sheet(isPresented: $isShowingAddSheet) {
                TodoDetailView()
            }
            .sheet(item: $selectedTodoToEdit) { todo in
                TodoDetailView(todoToEdit: todo)
            }
        }
    }

    // Empty State Component
    private var emptyStateView: some View {
        VStack(spacing: 16) {
            Spacer()
            Image(systemName: "checkmark.circle.trianglebadge.exclamationmark")
                .font(.system(size: 56))
                .foregroundStyle(.tertiary)

            Text(selectedFilter == .completed ? "No completed tasks yet" : "No tasks found")
                .font(.headline)
                .foregroundStyle(.secondary)

            Button(action: {
                isShowingAddSheet = true
            }) {
                Label("Add New Task", systemImage: "plus")
                    .font(.subheadline)
                    .fontWeight(.semibold)
            }
            .buttonStyle(.borderedProminent)
            Spacer()
        }
        .padding()
    }

    private func deleteTodos(at offsets: IndexSet) {
        for index in offsets {
            let todo = filteredTodos[index]
            modelContext.delete(todo)
        }
    }
}

/// Todo Row Item Component
struct TodoRowView: View {
    let todo: TodoItem
    let onTapEdit: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            // Checkmark Completion Toggle Button
            Button(action: {
                withAnimation {
                    todo.isCompleted.toggle()
                }
            }) {
                Image(systemName: todo.isCompleted ? "checkmark.circle.fill" : "circle")
                    .font(.title2)
                    .foregroundStyle(todo.isCompleted ? .green : .secondary)
            }
            .buttonStyle(.plain)

            // Title & Due Date Details
            VStack(alignment: .leading, spacing: 4) {
                Text(todo.title)
                    .font(.body)
                    .strikethrough(todo.isCompleted, color: .secondary)
                    .foregroundStyle(todo.isCompleted ? .secondary : .primary)

                if let dueDate = todo.dueDate {
                    HStack(spacing: 4) {
                        Image(systemName: "clock")
                            .font(.caption2)
                        Text(formattedDate(dueDate))
                            .font(.caption)
                    }
                    .foregroundStyle(dueDate < Date() && !todo.isCompleted ? .red : .secondary)
                }
            }

            Spacer()

            // Priority Badge
            PriorityBadge(priority: todo.priority)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            onTapEdit()
        }
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

/// Helper Priority Badge Component
struct PriorityBadge: View {
    let priority: TodoPriority

    var body: some View {
        Text(priority.rawValue)
            .font(.system(size: 10, weight: .bold))
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(color.opacity(0.15))
            .foregroundStyle(color)
            .clipShape(Capsule())
    }

    private var color: Color {
        switch priority {
        case .high: return .red
        case .medium: return .orange
        case .low: return .blue
        }
    }
}

#Preview {
    TodoListView()
        .modelContainer(for: TodoItem.self, inMemory: true)
}

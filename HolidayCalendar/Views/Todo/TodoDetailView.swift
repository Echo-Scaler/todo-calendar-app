import SwiftUI
import SwiftData

/// TodoDetailView
/// Sheet/Screen for Creating or Editing a TodoItem
struct TodoDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    var todoToEdit: TodoItem?

    @State private var title: String = ""
    @State private var isCompleted: Bool = false
    @State private var hasDueDate: Bool = false
    @State private var dueDate: Date = Date()
    @State private var priority: TodoPriority = .medium
    @State private var hasReminder: Bool = false
    @State private var reminderDate: Date = Date()

    private var isEditing: Bool {
        todoToEdit != nil
    }

    init(todoToEdit: TodoItem? = nil) {
        self.todoToEdit = todoToEdit
        if let todo = todoToEdit {
            _title = State(initialValue: todo.title)
            _isCompleted = State(initialValue: todo.isCompleted)
            _hasDueDate = State(initialValue: todo.dueDate != nil)
            _dueDate = State(initialValue: todo.dueDate ?? Date())
            _priority = State(initialValue: todo.priority)
            _hasReminder = State(initialValue: todo.reminderDate != nil)
            _reminderDate = State(initialValue: todo.reminderDate ?? Date())
        }
    }

    var body: some View {
        NavigationStack {
            Form {
                // Title Section
                Section("Task Information") {
                    TextField("What needs to be done?", text: $title)

                    Toggle("Completed", isOn: $isCompleted)
                }

                // Priority Section
                Section("Priority") {
                    Picker("Priority Level", selection: $priority) {
                        ForEach(TodoPriority.allCases, id: \.self) { prio in
                            Text(prio.rawValue).tag(prio)
                        }
                    }
                    .pickerStyle(.segmented)
                }

                // Due Date Section
                Section("Due Date") {
                    Toggle("Set Due Date", isOn: $hasDueDate.animation())

                    if hasDueDate {
                        DatePicker("Due Date & Time", selection: $dueDate, displayedComponents: [.date, .hourAndMinute])
                    }
                }

                // Reminder Section
                Section("Reminder") {
                    Toggle("Set Reminder", isOn: $hasReminder.animation())

                    if hasReminder {
                        DatePicker("Reminder Date & Time", selection: $reminderDate, displayedComponents: [.date, .hourAndMinute])
                    }
                }

                // Delete Action (If editing)
                if isEditing {
                    Section {
                        Button(role: .destructive, action: deleteTodo) {
                            HStack {
                                Spacer()
                                Image(systemName: "trash")
                                Text("Delete Task")
                                Spacer()
                            }
                        }
                    }
                }
            }
            .navigationTitle(isEditing ? "Edit Task" : "New Task")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveTodo()
                    }
                    .disabled(title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
    }

    private func saveTodo() {
        let finalDueDate: Date? = hasDueDate ? dueDate : nil
        let finalReminderDate: Date? = hasReminder ? reminderDate : nil
        let cleanTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)

        let targetTodo: TodoItem
        if let todo = todoToEdit {
            todo.title = cleanTitle
            todo.isCompleted = isCompleted
            todo.dueDate = finalDueDate
            todo.priority = priority
            todo.reminderDate = finalReminderDate
            targetTodo = todo
        } else {
            let newTodo = TodoItem(
                title: cleanTitle,
                isCompleted: isCompleted,
                dueDate: finalDueDate,
                priority: priority,
                reminderDate: finalReminderDate
            )
            modelContext.insert(newTodo)
            targetTodo = newTodo
        }

        // Notification Integration
        let notificationID = "todo-\(targetTodo.id.uuidString)"
        if hasReminder && !isCompleted {
            NotificationManager.shared.scheduleTodoReminder(for: targetTodo)
        } else {
            NotificationManager.shared.cancelNotification(id: notificationID)
        }

        dismiss()
    }

    private func deleteTodo() {
        if let todo = todoToEdit {
            NotificationManager.shared.cancelNotification(id: "todo-\(todo.id.uuidString)")
            modelContext.delete(todo)
        }
        dismiss()
    }
}

#Preview {
    TodoDetailView()
}

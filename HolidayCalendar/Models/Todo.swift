import Foundation

/// Priority Enum for Todo
enum TodoPriority: String, Codable, CaseIterable {
    case low
    case medium
    case high
}

/// Todo Data Model (Placeholder for Phase 5)
struct TodoItem: Identifiable, Codable, Hashable {
    let id: UUID
    var title: String
    var isCompleted: Bool
    var dueDate: Date?
    var priority: TodoPriority
    var reminderDate: Date?

    init(id: UUID = UUID(), title: String, isCompleted: Bool = false, dueDate: Date? = nil, priority: TodoPriority = .medium, reminderDate: Date? = nil) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
        self.dueDate = dueDate
        self.priority = priority
        self.reminderDate = reminderDate
    }
}

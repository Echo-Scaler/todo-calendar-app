import Foundation
import SwiftData

/// Todo Priority Enum
enum TodoPriority: String, Codable, CaseIterable {
    case low = "Low"
    case medium = "Medium"
    case high = "High"
}

/// SwiftData TodoItem Model
/// Phase 5: Managed persistent model for Todo tasks
@Model
final class TodoItem {
    var id: UUID
    var title: String
    var isCompleted: Bool
    var dueDate: Date?
    var priorityRaw: String
    var reminderDate: Date?
    var createdAt: Date

    init(
        id: UUID = UUID(),
        title: String,
        isCompleted: Bool = false,
        dueDate: Date? = nil,
        priority: TodoPriority = .medium,
        reminderDate: Date? = nil,
        createdAt: Date = Date()
    ) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
        self.dueDate = dueDate
        self.priorityRaw = priority.rawValue
        self.reminderDate = reminderDate
        self.createdAt = createdAt
    }

    var priority: TodoPriority {
        get { TodoPriority(rawValue: priorityRaw) ?? .medium }
        set { priorityRaw = newValue.rawValue }
    }
}

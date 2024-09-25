import Foundation

/// Main data stracture to handle data from JSON file
struct ToDoResponse: Decodable {
	let todos: [ToDo]
	let total: Int
	let skip: Int
	let limit: Int
}

/// Model to store properties ot the `ToDo` from JSON file
struct ToDo: Codable, Hashable {
	let id: Int
	var todo: String
	var completed: Bool
	let userId: Int
	var taskDescription: String?
	var deadline: Date?
	var creationDate: Date?
}

extension ToDo {

	/// Initialializer accordingly to Data Base
	/// - Parameter mo: Core Data Entity
	init(_ mo: ToDoMO) {
		id = Int(mo.id)
		todo = mo.todo
		completed = mo.completed
		userId = Int(mo.userId)
		taskDescription = mo.taskDescription
		deadline = mo.deadline
	}
}

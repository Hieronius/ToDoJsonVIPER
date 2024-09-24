import Foundation

/// Main data stracture to handle data from JSON file
struct ToDoResponse: Decodable {

	/// Tasks
	let todos: [ToDo]

	/// Total Amount of the tasks
	let total: Int
	let skip: Int
	let limit: Int
}

/// Model to store properties ot the `ToDo` from JSON file
struct ToDo: Codable, Hashable {

	/// Individual identifier of the task
	let id: Int

	/// Title of the task
	var todo: String

	/// Is Task been completed or not
	var completed: Bool

	/// Individual identifier for the task's owner
	let userId: Int

	/// Description of the User task
	var taskDescription: String?

	/// Date when user created the task
	var deadline: Date?
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

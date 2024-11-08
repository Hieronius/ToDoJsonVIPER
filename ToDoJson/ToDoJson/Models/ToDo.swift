import Foundation

/// Main data stracture to handle data from JSON file
struct ToDoResponse: Decodable {

	/// An array of tasks from the server
	let todos: [ToDo]

	/// Amount of the tasks taken from the server
	let total: Int

	/// Property to define how much tasks should be ignored
	let skip: Int

	/// Total amount of tasks which can be stored in the server
	let limit: Int
}

/// Model to store properties ot the `ToDo` from JSON file
struct ToDo: Codable, Hashable {

	/// `id` of the specific todo
	let id: Int

	/// `todo` it's self
	var todo: String

	/// Is task done or note
	var completed: Bool

	/// UserID generated unique when the app been running in first time
	let userId: Int

	/// Some details about the todo
	var taskDescription: String?

	/// Time to end the task
	var deadline: Date?

	/// Time when task has been created or modified
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

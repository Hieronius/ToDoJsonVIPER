import XCTest
@testable import ToDoJson

class TaskScreenPresenterMock: TaskScreenPresenterProtocol {

	var saveTaskCalled = false
	var updateTaskCalled = false
	var savedTaskTitle: String?
	var savedTaskDescription: String?
	var updatedTask: ToDo?

	func saveTask(title: String, description: String?, deadline: Date?, creationDate: Date?) {
		saveTaskCalled = true
		savedTaskTitle = title
		savedTaskDescription = description
	}

	func updateTask(_ task: ToDo, title: String, isCompleted: Bool, description: String?, deadline: Date?, creationDate: Date?) {
		updateTaskCalled = true
		updatedTask = task
	}
}

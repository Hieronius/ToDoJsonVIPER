import XCTest
@testable import ToDoJson

class TaskScreenInteractorMock: TaskScreenInteractorProtocol {

	var createTaskCalled = false
	var updateTaskCalled = false
	var createdTaskTitle: String?
	var createdTaskDescription: String?
	var updatedTask: ToDo?

	func createTask(title: String, description: String?, deadline: Date?, creationDate: Date?) {
		createTaskCalled = true
		createdTaskTitle = title
		createdTaskDescription = description
	}

	func updateTask(_ task: ToDo) {
		updateTaskCalled = true
		updatedTask = task
	}

	func setUserManager(_ userManager: UserManager) {}

	func setTaskIDManager(_ taskIDManager: TaskIDManager) {}
}

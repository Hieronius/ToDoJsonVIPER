import XCTest
@testable import ToDoJson

class ToDoDataManagerMock: ToDoDataManagerProtocol {
	var tasks = [ToDo]()

	func fetchAllToDos() -> [ToDo] {
		return tasks
	}

	func fetchAllToDosByCreationDate() -> [ToDo] {
		return tasks.sorted { $0.creationDate ?? Date() < $1.creationDate ?? Date() }
	}

	func createToDoMO(_ todo: ToDo) {
		tasks.append(todo)
	}
}


import XCTest
@testable import ToDoJson

class MainScreenInteractorProtocolMock: MainScreenInteractorProtocol {
	func parseTasks(completion: @escaping ([ToDoJson.ToDo]) -> Void) { }

	var loadTasksCalled = false
	var filterTasksReturnValue: [ToDo] = []

	func loadTasks() {
		loadTasksCalled = true
	}

	func filterTasks(by category: ToDoJson.Category) -> [ToDo] {
		return filterTasksReturnValue
	}
}

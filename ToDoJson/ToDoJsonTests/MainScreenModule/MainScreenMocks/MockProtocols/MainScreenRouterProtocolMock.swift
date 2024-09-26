import XCTest
@testable import ToDoJson

class MainScreenRouterProtocolMock: MainScreenRouterProtocol {
	var navigateToTaskScreenCalled = false
	var navigateToEditTaskCalled = false
	var editedTask: ToDo?

	func navigateToTaskScreen() {
		navigateToTaskScreenCalled = true
	}

	func navigateToEditTask(_ task: ToDo) {
		navigateToEditTaskCalled = true
		editedTask = task
	}
}

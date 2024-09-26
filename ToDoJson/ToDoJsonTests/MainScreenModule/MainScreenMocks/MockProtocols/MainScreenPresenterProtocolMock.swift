import XCTest
@testable import ToDoJson

class MainScreenPresenterProtocolMock: MainScreenPresenterProtocol {
	var newTaskButtonTappedCalled = false
	var editTaskCalled = false
	var showTasksCalled = false
	var showFilteredTasksCalled = false
	var editedTask: ToDo?

	var allTasks: [ToDo] { return [] }

	var filteredTasks: [ToDo] { return [] }

	func newTaskButtonTapped() {
		newTaskButtonTappedCalled = true
	}

	func editTask(_ task: ToDo) {
		editTaskCalled = true
		editedTask = task
	}

	func showTasks(_ tasks: [ToDo]) {
		showTasksCalled = true
	}

	func showFilteredTasks(_ tasks: [ToDo]) {
		showFilteredTasksCalled = true
	}

	func selectCategory(_ category: ToDoJson.Category) { }

	func viewDidLoad() { }
}

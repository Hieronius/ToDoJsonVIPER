import XCTest
@testable import ToDoJson

class MainScreenPresenterMock: MainScreenPresenterProtocol {
	var showTasksCalled = false
	var showFilteredTasksCalled = false
	var tasks: [ToDo] = []
	var filteredTasks: [ToDo] = []

	var allTasks: [ToDo] {
		return tasks
	}


	func viewDidLoad() {
	}

	func newTaskButtonTapped() {
	}

	func selectCategory(_ category: ToDoJson.Category) {
	}

	func editTask(_ task: ToDo) {
	}

	func showTasks(_ tasks: [ToDo]) {
		showTasksCalled = true
		self.tasks = tasks
	}

	func showFilteredTasks(_ tasks: [ToDo]) {
		showFilteredTasksCalled = true
		self.filteredTasks = tasks
	}
}

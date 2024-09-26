import XCTest
@testable import ToDoJson

class MainScreenViewInputMock: MainScreenViewInput {
	var displayTasksCalled = false
	var displayFilteredTasksCalled = false
	var updateCategoryColorsCalled = false

	var displayedTasks: [ToDo] = []
	var displayedFilteredTasks: [ToDo] = []

	func displayTasks(_ tasks: [ToDo]) {
		displayTasksCalled = true
		displayedTasks = tasks
	}

	func displayFilteredTasks(_ tasks: [ToDo]) {
		displayFilteredTasksCalled = true
		displayedFilteredTasks = tasks
	}

	func updateCategoryColors(selectedCategory: ToDoJson.Category) {
		updateCategoryColorsCalled = true
	}
}

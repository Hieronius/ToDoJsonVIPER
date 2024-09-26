import XCTest
@testable import ToDoJson

class TaskScreenViewControllerInputMock: TaskScreenViewInput {

	// MARK: - Properties

	var isPopulateFieldsIfEditingCalled = false
	var populatedTask: ToDo?

	// MARK: - TaskScreenViewInput Protocol Methods

	func populateFieldsIfEditing() {
		isPopulateFieldsIfEditingCalled = true
		populatedTask = ToDo(id: 1, todo: "Mock Task", completed: false, userId: 1, taskDescription: "Mock Description", deadline: Date(), creationDate: Date())
	}

}

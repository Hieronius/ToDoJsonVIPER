import XCTest
@testable import ToDoJson

class TaskScreenViewControllerTests: XCTestCase {

	var taskScreenViewController: TaskScreenViewController!
	var mockPresenter: TaskScreenPresenterMock!

	override func setUp() {
		super.setUp()
		taskScreenViewController = TaskScreenViewController()
		mockPresenter = TaskScreenPresenterMock()
		taskScreenViewController.presenter = mockPresenter
	}

	override func tearDown() {
		taskScreenViewController = nil
		mockPresenter = nil
		super.tearDown()
	}

	func testPresenterIsSet() {
		XCTAssertNotNil(taskScreenViewController.presenter, "Presenter should be set")
	}

	func testPopulateFieldsIfEditing() {
		let task = ToDo(id: 1, todo: "Test Task", completed: false, userId: 1, taskDescription: "Test Description", deadline: Date(), creationDate: Date())
		taskScreenViewController.task = task

		taskScreenViewController.loadViewIfNeeded()

		XCTAssertEqual(taskScreenViewController.rootView.taskTitleTextField.text, "Test Task", "Task title should be populated")
		XCTAssertEqual(taskScreenViewController.rootView.taskDescriptionTextField.text, "Test Description", "Task description should be populated")
		XCTAssertEqual(taskScreenViewController.rootView.deadlineDatePicker.date, task.deadline, "Deadline date picker should be set to task deadline")
	}

	func testSaveTaskCallsPresenterSaveMethod() {
		taskScreenViewController.rootView.taskTitleTextField.text = "New Task"
		taskScreenViewController.rootView.taskDescriptionTextField.text = "New Description"

		taskScreenViewController.saveTask()

		XCTAssertTrue(mockPresenter.saveTaskCalled, "saveTask should call presenter to save a new task")
		XCTAssertEqual(mockPresenter.savedTaskTitle, "New Task", "Presenter should receive the correct task title")
		XCTAssertEqual(mockPresenter.savedTaskDescription, "New Description", "Presenter should receive the correct task description")
	}

	func testUpdateTaskCallsPresenterUpdateMethod() {
		let existingTask = ToDo(id: 1, todo: "Existing Task", completed: false, userId: 1, taskDescription: "Existing Description", deadline: Date(), creationDate: Date())
		taskScreenViewController.task = existingTask

		taskScreenViewController.rootView.taskTitleTextField.text = "Updated Task"
		taskScreenViewController.rootView.taskDescriptionTextField.text = "Updated Description"

		taskScreenViewController.saveTask()

		XCTAssertTrue(mockPresenter.updateTaskCalled, "saveTask should call presenter to update an existing task")
		XCTAssertEqual(mockPresenter.updatedTask?.todo, "Updated Task", "Updated task title should be sent to presenter")
	}
}

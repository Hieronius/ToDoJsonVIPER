import XCTest
@testable import ToDoJson

class TaskScreenViewTests: XCTestCase {

	var taskScreenView: TaskScreenView!

	override func setUp() {
		super.setUp()
		taskScreenView = TaskScreenView()
	}

	override func tearDown() {
		taskScreenView = nil
		super.tearDown()
	}

	func testInitialization() {
		XCTAssertNotNil(taskScreenView.taskTitleTextField, "Task title text field should be initialized")
		XCTAssertNotNil(taskScreenView.taskDescriptionTextField, "Task description text field should be initialized")
		XCTAssertNotNil(taskScreenView.deadlineDatePicker, "Deadline date picker should be initialized")
		XCTAssertNotNil(taskScreenView.doneButton, "Done button should be initialized")
	}

	func testTextFieldsHavePlaceholders() {
		XCTAssertEqual(taskScreenView.taskTitleTextField.placeholder, "Enter title", "Task title text field should have correct placeholder")
		XCTAssertEqual(taskScreenView.taskDescriptionTextField.placeholder, "Enter description", "Task description text field should have correct placeholder")
	}

	func testDoneButtonActionIsSet() {
		let actions = taskScreenView.doneButton.actions(forTarget: taskScreenView, forControlEvent: .touchUpInside)

		XCTAssertTrue(actions?.contains("doneButtonTapped") ?? false, "Done button should have an action for touch up inside event")
	}

	func testLayoutConstraints() {

		XCTAssertFalse(taskScreenView.doneButton.translatesAutoresizingMaskIntoConstraints, "Done button should not use autoresizing masks")
	}
}

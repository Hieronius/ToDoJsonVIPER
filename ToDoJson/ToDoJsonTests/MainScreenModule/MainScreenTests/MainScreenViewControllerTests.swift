import XCTest
@testable import ToDoJson

class MainScreenViewControllerTests: XCTestCase {
	var mainScreenViewController: MainScreenViewController!
	var presenterMock: MainScreenPresenterProtocolMock!

	override func setUp() {
		super.setUp()
		presenterMock = MainScreenPresenterProtocolMock()
		mainScreenViewController = MainScreenViewController()
		mainScreenViewController.presenter = presenterMock
		mainScreenViewController.loadViewIfNeeded()
	}

	override func tearDown() {
		mainScreenViewController = nil
		presenterMock = nil
		super.tearDown()
	}

	func testPresenterIsSet() {
		XCTAssertNotNil(mainScreenViewController.presenter)
	}

	func testNewTaskButtonTappedCallsPresenter() {
		mainScreenViewController.moveToTaskScreen()
		XCTAssertTrue(presenterMock.newTaskButtonTappedCalled)
	}

	func testEditTaskCallsPresenter() {
		let todo = ToDo(id: 1, todo: "Test Task", completed: false, userId: 1)
		mainScreenViewController.editTask(todo)
		XCTAssertTrue(presenterMock.editTaskCalled)
		XCTAssertEqual(presenterMock.editedTask, todo)
	}

	func testUpdateCategoryColors() {
		let selectedCategory = Category.all
		mainScreenViewController.updateCategoryColors(selectedCategory: selectedCategory)

		XCTAssertEqual(mainScreenViewController.rootView.categoryAllNameLabel.textColor, .blue)
		XCTAssertEqual(mainScreenViewController.rootView.categoryOpenNameLabel.textColor, .gray)
		XCTAssertEqual(mainScreenViewController.rootView.categoryClosedNameLabel.textColor, .gray)
	}
}

import XCTest
@testable import ToDoJson

class MainScreenRouterTests: XCTestCase {
	var router: MainScreenRouter!
	var viewControllerMock: UIViewControllerMock!

	override func setUp() {
		super.setUp()
		router = MainScreenRouter()
		viewControllerMock = UIViewControllerMock()
		router.viewController = viewControllerMock
	}

	override func tearDown() {
		router = nil
		viewControllerMock = nil
		super.tearDown()
	}

	func testNavigateToTaskScreen() {
		router.navigateToTaskScreen()

		XCTAssertTrue(viewControllerMock.didPushViewControllerCalled, "Expected navigateToTaskScreen to push Task screen")
		XCTAssertTrue(viewControllerMock.pushedViewController is TaskScreenViewController, "Expected Task screen to be pushed")
	}

	func testNavigateToEditTask() {
		let todo = ToDo(id: 1, todo: "Test Task", completed: false, userId: 1)

		router.navigateToEditTask(todo)

		XCTAssertTrue(viewControllerMock.didPushViewControllerCalled, "Expected navigateToEditTask to push Edit Task screen")
		XCTAssertTrue(viewControllerMock.pushedViewController is TaskScreenViewController, "Expected Edit Task screen to be pushed")
	}
}

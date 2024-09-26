import XCTest
@testable import ToDoJson // Replace with your actual module name

class TaskScreenRouterTests: XCTestCase {

	var taskScreenRouter: TaskScreenRouter!
	var viewControllerMock: ViewControllerMock!

	override func setUp() {
		super.setUp()
		taskScreenRouter = TaskScreenRouter()
		viewControllerMock = ViewControllerMock()
		taskScreenRouter.viewController = viewControllerMock
	}

	override func tearDown() {
		taskScreenRouter = nil
		viewControllerMock = nil
		super.tearDown()
	}

	// Test to ensure navigateBackToMain pops the view controller
	func testNavigateBackToMain() {
		// Given
		let navigationController = UINavigationController(rootViewController: viewControllerMock)
		taskScreenRouter.viewController = viewControllerMock
		viewControllerMock.navigationController = navigationController

		// When
		taskScreenRouter.navigateBackToMain()

		// Then
		XCTAssertEqual(navigationController.viewControllers.count, 0, "The view controller should be popped from the navigation stack.")
	}
}

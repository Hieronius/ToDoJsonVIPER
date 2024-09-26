import XCTest
@testable import ToDoJson

class TaskScreenRouterMock: TaskScreenRouterProtocol {

	var navigateBackCalled = false

	func navigateBackToMain() {
		navigateBackCalled = true
	}
}

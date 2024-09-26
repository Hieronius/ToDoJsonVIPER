import XCTest
@testable import ToDoJson

class UIViewControllerMock: UIViewController {
	var didPushViewControllerCalled = false
	var pushedViewController: UIViewController?

	func pushViewController(_ viewController: UIViewController, animated: Bool) {
		didPushViewControllerCalled = true
		pushedViewController = viewController
	}
}

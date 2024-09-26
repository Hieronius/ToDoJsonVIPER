import XCTest
@testable import ToDoJson

class ViewControllerMock: UIViewController {
	private var _navigationController: UINavigationController?

	override var navigationController: UINavigationController? {
		get {
			return _navigationController
		}
		set {
			_navigationController = newValue
		}
	}

	var didLoadCalled = false

	override func viewDidLoad() {
		super.viewDidLoad()
		didLoadCalled = true // Track whether viewDidLoad was called
	}
}

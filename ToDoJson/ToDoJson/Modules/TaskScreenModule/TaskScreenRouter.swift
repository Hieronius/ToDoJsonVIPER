import UIKit

/// `Router` of the Task to manage it's building process and navigation
final class TaskScreenRouter: TaskScreenRouterProtocol {

	// MARK: - Public Properties

	/// Weak reference to the View to directly point that it's not "owns" it
	weak var viewController: UIViewController?

	// MARK: - Public Methods

	/// Method build the `TaskScreen` module with dependencies it's need to function correctly
	/// It sets up the relationships between these components by assigning their properties
	///
	/// - Returns: A fully configured `UIViewController` instance representing the TaskScreen
	static func createModule(with task: ToDo? = nil) -> UIViewController {
		let view = TaskScreenViewController()
		let presenter = TaskScreenPresenter()
		let interactor = TaskScreenInteractor()
		let router = TaskScreenRouter()
		
		view.presenter = presenter
		view.task = task
		presenter.view = view
		presenter.interactor = interactor
		presenter.router = router
		interactor.presenter = presenter
		router.viewController = view
		
		return view
	}

	/// Navigates back to the main screen.
	///
	/// This method pops the current view controller from the navigation stack
	func navigateBackToMain() {
		viewController?.navigationController?.popViewController(animated: true)
	}
}

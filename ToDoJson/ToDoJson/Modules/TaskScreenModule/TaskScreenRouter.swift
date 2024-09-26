import UIKit

/// Protocol that defines the interface for routing in the Task Screen module.
///
/// The `TaskScreenRouterProtocol` is implemented by the Router (e.g., `TaskScreenRouter`)
/// to handle navigation between screens and to create the Task Screen module.
protocol TaskScreenRouterProtocol {

	/// Creates and configures the Task Screen module.
	///
	/// - Parameter task: An optional `ToDo` object representing a task to be edited.
	/// If no task is provided, a new task will be created.
	/// - Returns: A configured instance of `UIViewController` representing the Task Screen.
	static func createModule(with task: ToDo?) -> UIViewController

	/// Navigates back to the Main Screen.
	///
	/// This method is called to return to the previous screen, typically after
	/// completing a task-related action or when the user cancels an operation.
	func navigateBackToMain()
}

/// `Router` TaskScreen
final class TaskScreenRouter: TaskScreenRouterProtocol {
	weak var viewController: UIViewController?
	
	static func createModule(with task: ToDo? = nil) -> UIViewController {
		let view = TaskScreenViewController()
		let presenter = TaskScreenPresenter()
		let interactor = TaskScreenInteractor()
		let router = TaskScreenRouter()
		
		interactor.setUserManager(UserManager.shared)
		interactor.setTaskIDManager(TaskIDManager.shared)
		
		view.presenter = presenter
		view.task = task
		presenter.view = view
		presenter.interactor = interactor
		presenter.router = router
		interactor.presenter = presenter
		router.viewController = view
		
		return view
	}
	
	func navigateBackToMain() {
		viewController?.navigationController?.popViewController(animated: true)
	}
}

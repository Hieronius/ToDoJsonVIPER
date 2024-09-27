import UIKit

/// Protocol that defines the interface for routing in the Main Screen module.
///
/// The `MainScreenRouterProtocol` is implemented by the Router (e.g., `MainScreenRouter`)
/// to handle navigation between screens and to create the module.
protocol MainScreenRouterProtocol: AnyObject {

	/// Creates and configures the Main Screen module.
	///
	/// - Returns: A configured instance of `UIViewController` representing the Main Screen.
	static func createModule() -> UIViewController

	/// Navigates to the Task screen.
	func navigateToTaskScreen()

	/// Navigates to the Edit Task screen with a specific task.
	///
	/// - Parameter task: The `ToDo` object representing the task to be edited.
	func navigateToEditTask(_ task: ToDo)
}

final class MainScreenRouter: MainScreenRouterProtocol {
	weak var viewController: UIViewController?

	static func createModule() -> UIViewController {
		let view = MainScreenViewController()
		let presenter = MainScreenPresenter()
		let todoService = ToDoService()
		let interactor = MainScreenInteractor(todoService: todoService)
		let router = MainScreenRouter()

		view.presenter = presenter
		presenter.view = view
		presenter.interactor = interactor
		presenter.router = router
		interactor.presenter = presenter
		router.viewController = view

		return view
	}

	func navigateToTaskScreen() {
		let taskVC = TaskScreenRouter.createModule()
		viewController?.navigationController?.pushViewController(taskVC, animated: true)
	}

	func navigateToEditTask(_ task: ToDo) {
		let taskVC = TaskScreenRouter.createModule(with: task)
		viewController?.navigationController?.pushViewController(taskVC, animated: true)
	}
}

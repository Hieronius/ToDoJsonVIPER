import UIKit

/// `Router` of the MainScreen to manage it's building process and navigation
final class MainScreenRouter: MainScreenRouterProtocol {

	// MARK: - Public Properties

	/// Weak reference to the VIPER's `View` to display that Router won't "own" View
	weak var viewController: UIViewController?

	// MARK: - Public Methods

	/// Method build the `MainScreen` module with dependencies it's need to function correctly
	/// It sets up the relationships between these components by assigning their properties
	///
	/// - Returns: A fully configured `UIViewController` instance representing the MainScreen
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

	/// Navigates to the Task Screen.
	///
	/// This method creates an instance of the Task Screen module and pushes it onto
	/// the navigation stack.
	///
	/// - Note: This method assumes that the `viewController` has a valid navigation controller.
	func navigateToTaskScreen() {
		let taskVC = TaskScreenRouter.createModule()
		viewController?.navigationController?.pushViewController(taskVC, animated: true)
	}

	/// Navigates to the Edit Task Screen for a specific task.
	///
	/// This method creates an instance of the Task Screen module configured for editing
	/// a specific task. It takes a `ToDo` object as a parameter and uses the
	/// `TaskScreenRouter` to create the module with this task. The new view controller
	/// is then pushed onto the navigation stack.
	///
	/// - Parameter task: The `ToDo` object representing the task to be edited.
	/// - Note: This method assumes that the `viewController` has a valid navigation controller.
	func navigateToEditTask(_ task: ToDo) {
		let taskVC = TaskScreenRouter.createModule(with: task)
		viewController?.navigationController?.pushViewController(taskVC, animated: true)
	}
}

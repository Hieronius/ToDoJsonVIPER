import UIKit

protocol MainScreenRouterProtocol {
	func navigateToTaskScreen()
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

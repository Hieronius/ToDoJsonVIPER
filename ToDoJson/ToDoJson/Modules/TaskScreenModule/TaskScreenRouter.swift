import UIKit

protocol TaskScreenRouterProtocol {
	func navigateBackToMain()
}

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

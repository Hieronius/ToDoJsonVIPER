protocol MainScreenPresenterProtocol: AnyObject {
	var tasks: [ToDo] { get }
	func viewDidLoad()
	func newTaskButtonTapped()
	func selectCategory(_ category: Category)
}

final class MainScreenPresenter: MainScreenPresenterProtocol {
	weak var view: MainScreenViewController?
	var interactor: MainScreenInteractorProtocol?
	var router: MainScreenRouterProtocol?

	private(set) var tasks = [ToDo]()

	func viewDidLoad() {
		interactor?.loadTasks()
	}

	func newTaskButtonTapped() {
		print("hello")
		router?.navigateToTaskScreen()
	}

	func showTasks(_ tasks: [ToDo]) {
		self.tasks = tasks
		view?.showTasks(tasks)
	}

	// New Methods for Handling Category Selection
		func selectCategory(_ category: Category) {
			let filteredTasks = interactor?.filterTasks(by: category) ?? []
			showTasks(filteredTasks)
			view?.updateCategoryColors(selectedCategory: category)
		}
}

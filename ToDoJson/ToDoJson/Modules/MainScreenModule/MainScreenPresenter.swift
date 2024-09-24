protocol MainScreenPresenterProtocol: AnyObject {
	var allTasks: [ToDo] { get }
	var filteredTasks: [ToDo] { get }
	func viewDidLoad()
	func newTaskButtonTapped()
	func selectCategory(_ category: Category)
}

final class MainScreenPresenter: MainScreenPresenterProtocol {
	weak var view: MainScreenViewController?
	var interactor: MainScreenInteractorProtocol?
	var router: MainScreenRouterProtocol?

	private(set) var allTasks = [ToDo]()
	private(set) var filteredTasks = [ToDo]()

	func viewDidLoad() {
		interactor?.loadTasks()
	}

	func newTaskButtonTapped() {
		print("hello")
		router?.navigateToTaskScreen()
	}

	func showTasks(_ tasks: [ToDo]) {
		allTasks = tasks
		view?.showTasks(tasks)
	}

	func showFilteredTasks(_ tasks: [ToDo]) {
		filteredTasks = tasks
		view?.showFilteredTasks(tasks)
	}

	// New Methods for Handling Category Selection
		func selectCategory(_ category: Category) {
			let filteredTasks = interactor?.filterTasks(by: category) ?? []
//			showTasks(filteredTasks)
			showFilteredTasks(filteredTasks)
			view?.updateCategoryColors(selectedCategory: category)
		}
}

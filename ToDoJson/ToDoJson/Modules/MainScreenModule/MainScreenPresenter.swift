import UIKit

/// `Presenter` of MainScreen with Tasks
final class MainScreenPresenter: MainScreenPresenterProtocol {
	weak var view: MainScreenViewInput?
	var interactor: MainScreenInteractorProtocol?
	var router: MainScreenRouterProtocol?
	
	private(set) var allTasks = [ToDo]()
	private(set) var filteredTasks = [ToDo]()
	
	func viewDidLoad() {
		interactor?.loadTasks()
		selectCategory(.all)
	}
	
	func newTaskButtonTapped() {
		router?.navigateToTaskScreen()
	}
	
	func editTask(_ task: ToDo) {
		router?.navigateToEditTask(task)
	}
	
	func showTasks(_ tasks: [ToDo]) {
		allTasks = tasks
		view?.displayTasks(tasks)
	}
	
	func showFilteredTasks(_ tasks: [ToDo]) {
		filteredTasks = tasks
		view?.displayFilteredTasks(tasks)
	}
	
	func selectCategory(_ category: Category) {
		let filteredTasks = interactor?.filterTasks(by: category) ?? []
		showFilteredTasks(filteredTasks)
		view?.updateCategoryColors(selectedCategory: category)
	}
}

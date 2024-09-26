/// Protocol that defines the interface for the Presenter to manage task-related actions.
///
/// The `MainScreenPresenterProtocol` is implemented by the Presenter (e.g., `MainScreenPresenter`)
/// to handle user interactions and communicate with the View and Interactor.
protocol MainScreenPresenterProtocol: AnyObject {

	/// An array of all tasks managed by the presenter.
	var allTasks: [ToDo] { get }

	/// An array of tasks that have been filtered based on the selected category.
	var filteredTasks: [ToDo] { get }

	/// Notifies the presenter that the view has loaded.
	///
	/// This method is called when the view is ready to display data.
	func viewDidLoad()

	/// Handles the action when the new task button is tapped.
	///
	/// This method is called when the user wants to create a new task.
	func newTaskButtonTapped()

	/// Selects a category to filter tasks.
	///
	/// - Parameter category: The category selected by the user for filtering tasks.
	func selectCategory(_ category: Category)

	/// Edits an existing task.
	///
	/// - Parameter task: The `ToDo` object representing the task to be edited.
	func editTask(_ task: ToDo)

	/// Displays a list of tasks in the view.
	///
	/// - Parameter tasks: An array of `ToDo` objects representing tasks to be displayed.
	func showTasks(_ tasks: [ToDo])

	/// Displays a filtered list of tasks in the view.
	///
	/// - Parameter tasks: An array of `ToDo` objects representing the filtered tasks to be displayed.
	func showFilteredTasks(_ tasks: [ToDo])
}

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

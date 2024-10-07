import UIKit

/// `Presenter` of MainScreen with Tasks
/// It acts as the intermediary between the view, interactor, and router in the VIPER architecture.
/// The presenter handles user interactions and updates the view with data.
final class MainScreenPresenter: MainScreenPresenterProtocol {

	// MARK: - Public Properties

	/// A weak reference to the view, conforming to `MainScreenViewInput`.
	weak var view: MainScreenViewInput?

	/// The interactor responsible for business logic and data management.
	var interactor: MainScreenInteractorProtocol?

	/// The router responsible for navigation within the application.
	var router: MainScreenRouterProtocol?

	/// An array holding all tasks.
	private(set) var allTasks = [ToDo]()

	/// An array holding filtered tasks based on category selection.
	private(set) var filteredTasks = [ToDo]()

	// MARK: - Public Methods

	/// Called when the view is loaded.
	///
	/// This method triggers loading of tasks from the interactor and selects
	/// the default category to display all tasks.
	func viewDidLoad() {
		interactor?.loadTasks()
		selectCategory(.all)
	}

	/// Called when the new task button is tapped.
	///
	/// This method instructs the router to navigate to the Task Screen for creating a new task.
	func newTaskButtonTapped() {
		router?.navigateToTaskScreen()
	}

	/// Edits an existing task.
	///
	/// This method navigates to the Edit Task Screen for a specific task.
	///
	/// - Parameter task: The `ToDo` object representing the task to be edited.
	func editTask(_ task: ToDo) {
		router?.navigateToEditTask(task)
	}

	/// Displays a list of tasks in the view.
	///
	/// This method updates the `allTasks` property with the provided tasks
	/// and instructs the view to display these tasks.
	///
	/// - Parameter tasks: An array of `ToDo` objects to be displayed in the view.
	func showTasks(_ tasks: [ToDo]) {
		allTasks = tasks
		view?.displayTasks(tasks)
	}

	/// Displays a list of filtered tasks in the view.
	///
	/// This method updates the `filteredTasks` property with the provided tasks
	/// and instructs the view to display these filtered tasks.
	///
	/// - Parameter tasks: An array of `ToDo` objects that have been filtered by category.
	func showFilteredTasks(_ tasks: [ToDo]) {
		filteredTasks = tasks
		view?.displayFilteredTasks(tasks)
	}

	/// Selects a category and filters tasks accordingly.
	///
	/// This method retrieves filtered tasks from the interactor based on
	/// the selected category and updates the view with these filtered tasks.
	///
	/// - Parameter category: The `Category` to filter tasks by.
	func selectCategory(_ category: Category) {
		let filteredTasks = interactor?.filterTasks(by: category) ?? []
		showFilteredTasks(filteredTasks)
		view?.updateCategoryColors(selectedCategory: category)
	}
}

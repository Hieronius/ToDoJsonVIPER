import UIKit

// MARK: - MainScreenViewInput

/// Protocol that defines the interface for the View to communicate with the Presenter.
///
/// The `MainScreenViewInput` protocol is implemented by the View (e.g., `MainScreenViewController`)
/// to receive updates from the Presenter. It provides methods for displaying tasks,
/// filtered tasks, and updating UI elements based on selected categories.
protocol MainScreenViewInput: AnyObject {

	/// Displays a list of tasks in the view.
	///
	/// - Parameter tasks: An array of `ToDo` objects representing tasks to be displayed.
	func displayTasks(_ tasks: [ToDo])

	/// Displays a filtered list of tasks in the view.
	///
	/// - Parameter tasks: An array of `ToDo` objects representing the filtered tasks to be displayed.
	func displayFilteredTasks(_ tasks: [ToDo])


	/// Updates the UI to reflect the colors associated with the selected category.
	///
	/// - Parameter selectedCategory: The category that has been selected by the user,
	/// which will determine how the UI elements are colored.
	func updateCategoryColors(selectedCategory: Category)
}

/// Protocol that defines the interface for the View to communicate user actions to the Presenter.
///
/// The `MainScreenViewOutput` protocol is implemented by the Presenter (e.g., `MainScreenPresenter`)
/// to handle user interactions from the View. It provides methods for responding to user actions
/// such as creating new tasks, editing existing tasks, selecting categories, and handling view lifecycle events.
protocol MainScreenViewOutput: AnyObject {

	/// Called when the user taps on the button to create a new task.
	func newTaskButtonTapped()

	/// Called when a task needs to be edited.
	///
	/// - Parameter todo: The `ToDo` object representing the task that is to be edited.
	func editTask(_ todo: ToDo)

	/// Called when a category is selected by the user.
	///
	/// - Parameter category: The `Category` object representing the category that has been selected.
	func selectCategory(_ category: Category)
}

// MARK: - MainScreenInteractorProtocol

/// Protocol that defines the interface for the interactor to manage tasks.
///
/// The `MainScreenInteractorProtocol` is implemented by the interactor (e.g., `MainScreenInteractor`)
/// to handle task management operations such as parsing, loading, and filtering tasks.
protocol MainScreenInteractorProtocol: AnyObject {

	/// Parses tasks from a data source and returns them asynchronously.
	///
	/// - Parameter completion: A closure that takes an array of `ToDo` objects as its parameter.
	/// This closure is called once the parsing is complete with the parsed tasks.
	func parseTasks(completion: @escaping ([ToDo]) -> Void)

	/// Loads tasks from a data source.
	///
	/// This method initiates the loading process and may notify other components when loading is complete.
	func loadTasks()

	/// Filters tasks based on the specified category.
	///
	/// - Parameter category: An instance of `Category` used to filter the tasks.
	/// - Returns: An array of `ToDo` objects that belong to the specified category.
	func filterTasks(by category: Category) -> [ToDo]
}

// MARK: - MainScreenPresenterProtocol

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

// MARK: - MainScreenRouterProtocol

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

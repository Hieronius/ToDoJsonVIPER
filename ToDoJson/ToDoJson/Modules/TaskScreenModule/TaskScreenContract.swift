import UIKit

// MARK: - TaskScreenViewInput

/// Protocol that defines the interface for the View to communicate with the Presenter.
///
/// The `TaskScreenViewInput` protocol is implemented by the View (e.g., `TaskScreenViewController`)
/// to receive updates from the Presenter. It provides methods for populating task details.
protocol TaskScreenViewInput: AnyObject {

	/// Populates the UI with task details for editing.
	///
	/// - Parameter task: The `ToDo` object representing the task to be displayed.
	func populateFieldsIfEditing()
}

// MARK: - TaskScreenInteractorProtocol

/// Protocol that defines the interface for the interactor to manage task-related operations.
///
/// The `TaskScreenInteractorProtocol` is implemented by the interactor (e.g., `TaskScreenInteractor`)
/// to handle the creation and updating of tasks, as well as managing user and task ID information.
protocol TaskScreenInteractorProtocol: AnyObject {

	/// Creates a new task with the specified details.
	///
	/// - Parameters:
	///   - title: A string representing the title of the task.
	///   - description: An optional string providing a description of the task.
	///   - deadline: An optional `Date` representing the deadline for the task.
	///   - creationDate: An optional `Date` representing when the task was created.
	func createTask(title: String, description: String?, deadline: Date?, creationDate: Date?)

	/// Updates an existing task with new information.
	///
	/// - Parameter task: The `ToDo` object representing the task to be updated.
	func updateTask(_ task: ToDo)

	/// Sets the user manager responsible for handling user-related operations.
	///
	/// - Parameter userManager: An instance of `UserManager` used for managing user data and actions.
	func setUserManager(_ userManager: UserManager)

	/// Sets the task ID manager responsible for generating or managing unique task identifiers.
	///
	/// - Parameter taskIDManager: An instance of `TaskIDManager` used for managing task IDs.
	func setTaskIDManager(_ taskIDManager: TaskIDManager)
}

// MARK: - TaskScreenPresenterProtocol

/// Protocol that defines the interface for the Presenter to manage task-related actions.
///
/// The `TaskScreenPresenterProtocol` is implemented by the Presenter (e.g., `TaskScreenPresenter`)
/// to handle user interactions related to task creation and updates.
protocol TaskScreenPresenterProtocol: AnyObject {

	/// Saves a new task with the specified details.
	///
	/// - Parameters:
	///   - title: A string representing the title of the task.
	///   - description: An optional string providing a description of the task.
	///   - deadline: An optional `Date` representing the deadline for the task.
	///   - creationDate: An optional `Date` representing when the task was created.
	func saveTask(
		title: String,
		description: String?,
		deadline: Date?,
		creationDate: Date?
	)

	/// Updates an existing task with new information.
	///
	/// - Parameters:
	///   - task: The `ToDo` object representing the task to be updated.
	///   - title: A string representing the new title of the task.
	///   - isCompleted: A boolean indicating whether the task is completed or not.
	///   - description: An optional string providing a new description of the task.
	///   - deadline: An optional `Date` representing the new deadline for the task.
	///   - creationDate: An optional `Date` representing when the task was created.
	func updateTask(
		_ task: ToDo,
		title: String,
		isCompleted: Bool,
		description: String?,
		deadline: Date?,
		creationDate: Date?
	)
}

// MARK: - TaskScreenRouterProtocol

/// Protocol that defines the interface for routing in the Task Screen module.
///
/// The `TaskScreenRouterProtocol` is implemented by the Router (e.g., `TaskScreenRouter`)
/// to handle navigation between screens and to create the Task Screen module.
protocol TaskScreenRouterProtocol: AnyObject {

	/// Creates and configures the Task Screen module.
	///
	/// - Parameter task: An optional `ToDo` object representing a task to be edited.
	/// If no task is provided, a new task will be created.
	/// - Returns: A configured instance of `UIViewController` representing the Task Screen.
	static func createModule(with task: ToDo?) -> UIViewController

	/// Navigates back to the Main Screen.
	///
	/// This method is called to return to the previous screen, typically after
	/// completing a task-related action or when the user cancels an operation.
	func navigateBackToMain()
}

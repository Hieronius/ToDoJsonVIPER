import Foundation

/// `Presenter` for the TaskScreen
/// The presenter handles user interactions related to task creation and updates.
final class TaskScreenPresenter: TaskScreenPresenterProtocol {

	// MARK: Public Properties

	/// A weak reference to the view to directly say that it won't "own" it
	weak var view: TaskScreenViewInput?

	/// The interactor responsible for business logic and data management.
	var interactor: TaskScreenInteractorProtocol?

	/// The router responsible for navigation within the application.
	var router: TaskScreenRouterProtocol?

	// MARK: - Public Methods

	/// Saves a new task with the provided details.
	///
	/// This method instructs the interactor to create a new task using the provided title,
	/// description, deadline, and creation date. After saving the task, it navigates back
	/// to the main screen.
	///
	/// - Parameters:
	///   - title: The title of the task.
	///   - description: An optional description of the task.
	///   - deadline: An optional deadline for the task.
	///   - creationDate: An optional creation date for the task. If not provided, defaults to the current date.
	func saveTask(
		title: String,
		description: String?,
		deadline: Date?,
		creationDate: Date?
	) {
		interactor?.createTask(
			title: title,
			description: description,
			deadline: deadline,
			creationDate: Date()
		)

		router?.navigateBackToMain()
	}

	/// Updates an existing task with new details.
	///
	/// This method modifies the specified task with updated information such as title,
	/// completion status, description, deadline, and creation date. After updating,
	/// it navigates back to the main screen.
	///
	/// - Parameters:
	///   - task: The `ToDo` object representing the task to be updated.
	///   - title: The new title of the task.
	///   - isCompleted: A boolean indicating whether the task is completed.
	///   - description: An optional new description of the task.
	///   - deadline: An optional new deadline for the task.
	///   - creationDate: An optional new creation date for the task.
	func updateTask(
		_ task: ToDo,
		title: String,
		isCompleted: Bool,
		description: String?,
		deadline: Date?,
		creationDate: Date?
	) {
		var updatedTask = task

		updatedTask.todo = title
		updatedTask.completed = isCompleted
		updatedTask.taskDescription = description
		updatedTask.deadline = deadline
		updatedTask.creationDate = creationDate

		interactor?.updateTask(updatedTask)

		router?.navigateBackToMain()
	}
}

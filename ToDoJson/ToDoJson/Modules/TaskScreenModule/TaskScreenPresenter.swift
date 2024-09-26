import Foundation

/// Protocol that defines the interface for the Presenter to manage task-related actions.
///
/// The `TaskScreenPresenterProtocol` is implemented by the Presenter (e.g., `TaskScreenPresenter`)
/// to handle user interactions related to task creation and updates.
protocol TaskScreenPresenterProtocol {

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

/// `Presenter` for the TaskScreen
final class TaskScreenPresenter: TaskScreenPresenterProtocol {
	weak var view: TaskScreenViewInput?
	var interactor: TaskScreenInteractorProtocol?
	var router: TaskScreenRouterProtocol?

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

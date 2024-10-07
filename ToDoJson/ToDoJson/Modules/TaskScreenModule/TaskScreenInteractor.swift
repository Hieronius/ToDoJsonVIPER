import Foundation

/// `Interactor` for TaskScreen
/// It is responsible for handling business logic related to task creation and updates.
/// The interactor communicates with the data layer to manage tasks and user information.
final class TaskScreenInteractor: TaskScreenInteractorProtocol {

	// MARK: - Public Properties

	/// A weak reference to the presenter to directly say that it won't "own" it
	weak var presenter: TaskScreenPresenter?

	// MARK: - Dependencies

	private var userManager: UserManagerProtocol
	private var taskIDManager: TaskIDManagerProtocol

	// MARK: - Initialization

	/// Initializes the interactor with specified user and task ID managers.
	///
	/// - Parameters:
	///   - userManager: An instance conforming to `UserManagerProtocol`. Defaults to the shared instance of `UserManager`.
	///   - taskIDManager: An instance conforming to `TaskIDManagerProtocol`. Defaults to the shared instance of `TaskIDManager`.
	init(
		userManager: UserManagerProtocol = UserManager.shared,
		taskIDManager: TaskIDManagerProtocol = TaskIDManager.shared
	) {
		self.userManager = userManager
		self.taskIDManager = taskIDManager
	}

	// MARK: - Public Methods

	/// Creates a new task with the provided details.
	///
	/// This method generates a new `ToDo` object using the specified title, description,
	/// deadline, and creation date. It retrieves the current user's ID from the user manager.
	/// If the user ID is not available, it prints an error message and returns without creating a task.
	///
	/// - Parameters:
	///   - title: The title of the new task.
	///   - description: An optional description of the new task.
	///   - deadline: An optional deadline for the new task.
	///   - creationDate: An optional creation date for the new task. Defaults to the current date if not provided.
	func createTask(title: String, description: String?, deadline: Date?, creationDate: Date?) {

		guard let userId = userManager.userId else {
			print("Error: User ID is not available.")
			return
		}

		let newTask = ToDo(id: taskIDManager.generateNewID(),
						   todo: title,
						   completed: false,
						   userId: userId,
						   taskDescription: description ?? "",
						   deadline: deadline ?? Date(),
						   creationDate: creationDate ?? Date())
		ToDoDataManager.shared.createToDoMO(newTask)
	}

	/// Updates an existing task with new details.
	///
	/// This method updates the specified `ToDo` object in the data manager, reflecting any changes made to it.
	///
	/// - Parameter task: The `ToDo` object representing the task to be updated.
	func updateTask(_ task: ToDo) {
		ToDoDataManager.shared.updateToDo(task)
	}
}

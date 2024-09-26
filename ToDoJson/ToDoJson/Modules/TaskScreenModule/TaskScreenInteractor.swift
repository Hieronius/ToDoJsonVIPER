import Foundation

/// Protocol that defines the interface for the interactor to manage task-related operations.
///
/// The `TaskScreenInteractorProtocol` is implemented by the interactor (e.g., `TaskScreenInteractor`)
/// to handle the creation and updating of tasks, as well as managing user and task ID information.
protocol TaskScreenInteractorProtocol {

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

/// `Interactor` for TaskScreen
final class TaskScreenInteractor: TaskScreenInteractorProtocol {
	weak var presenter: TaskScreenPresenter?

	private var userManager: UserManager?
	private var taskIDManager: TaskIDManager?

	func setUserManager(_ userManager: UserManager) {
		self.userManager = userManager
	}

	func setTaskIDManager(_ taskIDManager: TaskIDManager) {
		self.taskIDManager = taskIDManager
	}

	func createTask(title: String, description: String?, deadline: Date?, creationDate: Date?) {

		guard let userId = userManager?.userId else {
			print("Error: User ID is not available.")
			return
		}

		let newTask = ToDo(id: taskIDManager?.generateNewID() ?? 1000,
						   todo: title,
						   completed: false,
						   userId: userId,
						   taskDescription: description ?? "",
						   deadline: deadline ?? Date(),
						   creationDate: creationDate ?? Date())
		ToDoDataManager.shared.createToDoMO(newTask)
	}

	func updateTask(_ task: ToDo) {
		ToDoDataManager.shared.updateToDo(task)
	}
}

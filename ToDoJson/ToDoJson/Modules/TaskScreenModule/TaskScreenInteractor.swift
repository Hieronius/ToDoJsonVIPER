import Foundation

/// `Interactor` for TaskScreen
final class TaskScreenInteractor: TaskScreenInteractorProtocol {

	weak var presenter: TaskScreenPresenter?

	private var userManager: UserManagerProtocol
	private var taskIDManager: TaskIDManagerProtocol

	init(
		userManager: UserManagerProtocol = UserManager.shared,
		taskIDManager: TaskIDManagerProtocol = TaskIDManager.shared
	) {
		self.userManager = userManager
		self.taskIDManager = taskIDManager
	}

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

	func updateTask(_ task: ToDo) {
		ToDoDataManager.shared.updateToDo(task)
	}
}

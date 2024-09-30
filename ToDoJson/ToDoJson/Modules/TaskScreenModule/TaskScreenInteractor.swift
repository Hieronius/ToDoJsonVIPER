import Foundation

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

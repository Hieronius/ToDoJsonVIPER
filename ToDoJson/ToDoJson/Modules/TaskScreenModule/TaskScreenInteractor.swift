import Foundation

protocol TaskScreenInteractorProtocol {
	func createTask(title: String, description: String?, deadline: Date?, creationDate: Date?)
	func updateTask(_ task: ToDo)
	func setUserManager(_ userManager: UserManager)
		func setTaskIDManager(_ taskIDManager: TaskIDManager)
}

class TaskScreenInteractor: TaskScreenInteractorProtocol {
	weak var presenter: TaskScreenPresenter?

	private var userManager: UserManager?
		private var taskIDManager: TaskIDManager?

	// Setters for dependency injection
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
		print("New task created:", newTask)
	}


	func updateTask(_ task: ToDo) {
		ToDoDataManager.shared.updateToDo(task)
		print("updated task created:", task)
	}
}

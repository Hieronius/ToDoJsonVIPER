import Foundation

protocol TaskScreenInteractorProtocol {
//	func createTask(_ task: ToDo)
	func createTask(title: String, description: String?, deadline: Date?, creationDate: Date?)
	func updateTask(_ task: ToDo)
}

class TaskScreenInteractor: TaskScreenInteractorProtocol {
	weak var presenter: TaskScreenPresenter?

	func createTask(title: String, description: String?, deadline: Date?, creationDate: Date?) {
		let newTask = ToDo(id: Int.random(in: 1...1000), // Consider moving ID generation to data manager
						   todo: title,
						   completed: false,
						   userId: Int.random(in: 1...1000), // Same for userId
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

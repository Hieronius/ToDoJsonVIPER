import Foundation

protocol TaskScreenInteractorProtocol {
	func createTask(_ task: ToDo)
	func updateTask(_ task: ToDo)
}

class TaskScreenInteractor: TaskScreenInteractorProtocol {
	var presenter: TaskScreenPresenter?

	func createTask(_ task: ToDo) {
		ToDoDataManager.shared.createToDoMO(task)
		print("New task created:", task)
	}

	func updateTask(_ task: ToDo) {
		ToDoDataManager.shared.updateToDo(task)
		print("updated task created:", task)
	}
}

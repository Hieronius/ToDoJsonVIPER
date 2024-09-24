import Foundation

protocol TaskScreenInteractorProtocol {
	func createTask(_ task: ToDo)
}

class TaskScreenInteractor: TaskScreenInteractorProtocol {
	var presenter: TaskScreenPresenter?

	func createTask(_ task: ToDo) {
		ToDoDataManager.shared.createToDoMO(task)
		print("New task created:", task)
	}
}

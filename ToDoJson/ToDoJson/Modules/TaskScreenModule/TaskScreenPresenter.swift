import Foundation

protocol TaskScreenPresenterProtocol {
	func saveTask(title: String, description: String?, deadline: Date?, creationDate: Date?)
	func updateTask(_ task: ToDo, title: String, isCompleted: Bool, description: String?, deadline: Date?, creationDate: Date?)
}

class TaskScreenPresenter: TaskScreenPresenterProtocol {
	weak var view: TaskScreenViewController?
	var interactor: TaskScreenInteractorProtocol?
	var router: TaskScreenRouterProtocol?

	func saveTask (title: String, description: String?, deadline: Date?, creationDate: Date?) {
		let newTask = ToDo(id: Int.random(in: 1...1000),
						   todo: title,
						   completed: false,
						   userId: Int.random(in: 1...1000),
						   taskDescription: description ?? "",
						   deadline: deadline ?? Date(),
						   creationDate: Date())
			interactor?.createTask(newTask)
			router?.navigateBackToMain()
		}

	func updateTask(_ task: ToDo, title: String, isCompleted: Bool, description: String?, deadline: Date?, creationDate: Date?) {
			// Update the properties of the existing task
			var updatedTask = task

			// Update properties
			updatedTask.todo = title
		    updatedTask.completed = isCompleted
			updatedTask.taskDescription = description
			updatedTask.deadline = deadline
			updatedTask.creationDate = creationDate // This will use Date() if not provided

			// Save changes through interactor or data manager
			interactor?.updateTask(updatedTask)

			// Navigate back after updating
			router?.navigateBackToMain()
		}
}

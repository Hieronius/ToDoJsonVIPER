import Foundation

protocol TaskScreenPresenterProtocol {
	func saveTask(title: String, description: String?, deadline: Date?, creationDate: Date?)
	func updateTask(_ task: ToDo, title: String, isCompleted: Bool, description: String?, deadline: Date?, creationDate: Date?)
}

class TaskScreenPresenter: TaskScreenPresenterProtocol {
	weak var view: TaskScreenViewInput?
	var interactor: TaskScreenInteractorProtocol?
	var router: TaskScreenRouterProtocol?

	func saveTask(title: String, description: String?, deadline: Date?, creationDate: Date?) {
		// Call interactor's createTask method instead of creating a new task here
		interactor?.createTask(title: title, description: description, deadline: deadline, creationDate: Date())

		// Navigate back after saving
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

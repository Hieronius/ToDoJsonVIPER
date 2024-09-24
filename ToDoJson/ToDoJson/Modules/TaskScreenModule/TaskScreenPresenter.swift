import Foundation

protocol TaskScreenPresenterProtocol {
	func saveTask(title: String, description: String?, deadline: Date?)
	func updateTask(_ task: ToDo, title: String, description: String?, deadline: Date?)
}

class TaskScreenPresenter: TaskScreenPresenterProtocol {
	weak var view: TaskScreenViewController?
	var interactor: TaskScreenInteractorProtocol?
	var router: TaskScreenRouterProtocol?

	func saveTask (title: String, description: String?, deadline: Date?) {
			let newTask = ToDo(id: 100, todo: title, completed: false, userId: 200, taskDescription: description!, deadline: deadline! )
			interactor?.createTask(newTask)
			router?.navigateBackToMain()
		}

	func updateTask(_ task: ToDo, title: String, description: String?, deadline: Date?) {
			// Update the properties of the existing task
		var updatedTask = task

			// Update properties
			updatedTask.todo = title
			updatedTask.taskDescription = description
			updatedTask.deadline = deadline

			// Save changes through interactor or data manager
			interactor?.updateTask(updatedTask)

			// Navigate back after updating
			router?.navigateBackToMain()
		}
}

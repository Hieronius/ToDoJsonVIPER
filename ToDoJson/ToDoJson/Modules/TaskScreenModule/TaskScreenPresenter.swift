import Foundation

protocol TaskScreenPresenterProtocol {
	func saveTask(title: String, description: String?, deadline: Date?)
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
}

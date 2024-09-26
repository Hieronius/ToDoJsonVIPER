import Foundation

protocol TaskScreenPresenterProtocol {
	func saveTask(
		title: String,
		description: String?,
		deadline: Date?,
		creationDate: Date?
	)
	func updateTask(
		_ task: ToDo,
		title: String,
		isCompleted: Bool,
		description: String?,
		deadline: Date?,
		creationDate: Date?
	)
}

final class TaskScreenPresenter: TaskScreenPresenterProtocol {
	weak var view: TaskScreenViewInput?
	var interactor: TaskScreenInteractorProtocol?
	var router: TaskScreenRouterProtocol?

	func saveTask(
		title: String,
		description: String?,
		deadline: Date?,
		creationDate: Date?
	) {
		interactor?.createTask(
			title: title,
			description: description,
			deadline: deadline,
			creationDate: Date()
		)

		router?.navigateBackToMain()
	}

	func updateTask(
		_ task: ToDo,
		title: String,
		isCompleted: Bool,
		description: String?,
		deadline: Date?,
		creationDate: Date?
	) {
		var updatedTask = task

		updatedTask.todo = title
		updatedTask.completed = isCompleted
		updatedTask.taskDescription = description
		updatedTask.deadline = deadline
		updatedTask.creationDate = creationDate

		interactor?.updateTask(updatedTask)

		router?.navigateBackToMain()
	}
}

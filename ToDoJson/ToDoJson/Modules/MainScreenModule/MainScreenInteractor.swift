import Foundation

protocol MainScreenInteractorProtocol {
	func parseTasks()
	func loadTasks()
	func filterTasks(by category: Category) -> [ToDo]
}

final class MainScreenInteractor: MainScreenInteractorProtocol {
	var presenter: MainScreenPresenter?

	private let todoService: ToDoService

	init(todoService: ToDoService) {
		self.todoService = todoService
	}

	func  parseTasks() {
		todoService.fetchTasks { [weak self] result in
			switch result {
			case .success(let todos):
				self?.presenter?.showTasks(todos)
				print("got tasks from JSON")
			case .failure(let error):
				print("Error fetching tasks: \(error)")
			}
		}
	}

	func loadTasks() {
		let coreDataTasks = ToDoDataManager.shared.fetchAllToDos()

		// First run of the app
		if coreDataTasks.isEmpty {

			// Start by parsing tasks from JSON
			parseTasks { [weak self] jsonTasks in
				guard let self = self else { return }

				jsonTasks.forEach {
					ToDoDataManager.shared.createToDoMO($0)
				}

				self.presenter?.showTasks(jsonTasks)

				print("Loaded and combined tasks from JSON and Core Data")
			}
		} else {

			// Otherwise just load the tasks from CoreData to display
			self.presenter?.showTasks(coreDataTasks)
		}
	}

	private func parseTasks(completion: @escaping ([ToDo]) -> Void) {
			todoService.fetchTasks { result in
				switch result {
				case .success(let todos):
					print("Got tasks from JSON")
					completion(todos)
				case .failure(let error):
					print("Error fetching tasks: \(error)")
					completion([]) // Return an empty array on failure
				}
			}
		}

	// New Methods for Filtering
		func filterTasks(by category: Category) -> [ToDo] {
			switch category {
			case .all:
				return ToDoDataManager.shared.fetchAllToDos()
			case .completed:
				return ToDoDataManager.shared.fetchAllToDos().filter { $0.completed }
			case .uncompleted:
				return ToDoDataManager.shared.fetchAllToDos().filter { !$0.completed }
			}
		}
}

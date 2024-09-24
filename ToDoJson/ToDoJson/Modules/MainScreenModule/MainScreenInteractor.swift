import Foundation

protocol MainScreenInteractorProtocol {
	func parseTasks(completion: @escaping ([ToDo]) -> Void)
	func loadTasks()
	func filterTasks(by category: Category) -> [ToDo]
}

final class MainScreenInteractor: MainScreenInteractorProtocol {
	var presenter: MainScreenPresenter?

	private let todoService: ToDoService

	init(todoService: ToDoService) {
		self.todoService = todoService
	}

	func parseTasks(completion: @escaping ([ToDo]) -> Void) {
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

	func loadTasks() {
			// Use a background queue for loading tasks
			DispatchQueue.global(qos: .utility).async { [weak self] in
				guard let self else { return }

				let coreDataTasks = ToDoDataManager.shared.fetchAllToDos()

				if coreDataTasks.isEmpty {
					self.parseTasks { [weak self] jsonTasks in
						guard let self else { return }

						jsonTasks.forEach {
							ToDoDataManager.shared.createToDoMO($0)
						}

						// Update UI on the main queue
						DispatchQueue.main.async {
							self.presenter?.showTasks(jsonTasks)
							print("Loaded and combined tasks from JSON and Core Data")
						}
					}
				} else {
					// Update UI on the main queue
					DispatchQueue.main.async {
						print("Loaded tasks from CoreData only")
						self.presenter?.showTasks(coreDataTasks)
					}
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

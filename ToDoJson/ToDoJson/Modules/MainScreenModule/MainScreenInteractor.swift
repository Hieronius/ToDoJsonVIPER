import Foundation

/// Protocol that defines the interface for the interactor to manage tasks.
///
/// The `MainScreenInteractorProtocol` is implemented by the interactor (e.g., `MainScreenInteractor`)
/// to handle task management operations such as parsing, loading, and filtering tasks.
protocol MainScreenInteractorProtocol: AnyObject {

	/// Parses tasks from a data source and returns them asynchronously.
	///
	/// - Parameter completion: A closure that takes an array of `ToDo` objects as its parameter.
	/// This closure is called once the parsing is complete with the parsed tasks.
	func parseTasks(completion: @escaping ([ToDo]) -> Void)

	/// Loads tasks from a data source.
	///
	/// This method initiates the loading process and may notify other components when loading is complete.
	func loadTasks()

	/// Filters tasks based on the specified category.
	///
	/// - Parameter category: An instance of `Category` used to filter the tasks.
	/// - Returns: An array of `ToDo` objects that belong to the specified category.
	func filterTasks(by category: Category) -> [ToDo]
}

/// `Interactor` of the MainScreen with tasks
final class MainScreenInteractor: MainScreenInteractorProtocol {
	weak var presenter: MainScreenPresenter?
	
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
				completion([])
			}
		}
	}
	
	func loadTasks() {
		DispatchQueue.global(qos: .utility).async { [weak self] in
			guard let self else { return }
			
			let coreDataTasks = ToDoDataManager.shared.fetchAllToDosByCreationDate()
			
			if coreDataTasks.isEmpty {
				self.parseTasks { [weak self] jsonTasks in
					guard let self else { return }
					
					jsonTasks.forEach {
						ToDoDataManager.shared.createToDoMO($0)
					}
					
					DispatchQueue.main.async {
						self.presenter?.showTasks(jsonTasks)
						print("Loaded and combined tasks from JSON and Core Data")
					}
				}
			} else {
				DispatchQueue.main.async {
					print("Loaded tasks from CoreData only")
					self.presenter?.showTasks(coreDataTasks)
				}
			}
		}
	}
	
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

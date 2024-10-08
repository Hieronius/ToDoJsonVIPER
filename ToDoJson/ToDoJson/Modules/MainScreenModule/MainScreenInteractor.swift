import Foundation

/// `Interactor` of the MainScreen with tasks
/// It is responsible for handling business logic related to tasks, including fetching,
/// parsing, and filtering tasks. The interactor communicates with the service layer
/// to retrieve data and informs the presenter of any updates.
final class MainScreenInteractor: MainScreenInteractorProtocol {

	// MARK: - Public Properties

	/// A weak reference to the presenter
	weak var presenter: MainScreenPresenter?

	// MARK: - Private Properties

	private let todoService: ToDoServiceProtocol

	// MARK: - Initialization

	/// Initializes the interactor with a given `ToDoService`.
	///
	/// - Parameter todoService: An instance of `ToDoService` used for fetching tasks.
	init(todoService: ToDoServiceProtocol) {
		self.todoService = todoService
	}

	// MARK: - Public Methods

	/// Parses tasks fetched from the service and returns them via a completion handler.
	///
	/// - Parameter completion: A closure that takes an array of `ToDo` objects as its parameter.
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

	/// Loads tasks either from Core Data or by fetching them from a remote source.
	///
	/// This method checks if there are existing tasks in Core Data. If there are no tasks,
	/// it fetches tasks from a remote source using `parseTasks`. Once fetched, it creates
	/// new task objects in Core Data and informs the presenter to display these tasks.
	/// If tasks are found in Core Data, it directly informs the presenter with those tasks.
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

	/// Filters tasks based on the specified category.
	///
	/// This method returns an array of `ToDo` objects filtered by the given category.
	/// It handles three categories: all, completed, and uncompleted.
	///
	/// - Parameter category: The `Category` to filter tasks by.
	/// - Returns: An array of `ToDo` objects matching the specified category.
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

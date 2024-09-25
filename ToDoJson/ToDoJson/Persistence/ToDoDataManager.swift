import CoreData

/// App Data Storage Manager
final class ToDoDataManager {

	// MARK: Public Properties

	static let shared = ToDoDataManager()

	// MARK: - Private Properties

	/// App Data Storage Container
	private var persistentContainer = PersistentContainer()

	/// App Data Storage Context
	private lazy var context = persistentContainer.context

	// MARK: Initialization

	private init() {}

	// MARK: - Private Methods

	/// Method to save current core data context
	func saveContext() {
		if context.hasChanges {
			do {
				try context.save()
			} catch {
				fatalError(error.localizedDescription)
			}
		}
	}

	/// Method to fetch all `ManagedObject` of App Data Storage
	private func fetchAllMOs<MO: NSManagedObject>() -> [MO] {
		let request = NSFetchRequest<MO>(entityName: "ToDoMO")
		do {
			return try context.fetch(request)
		} catch {
			print("Failed to fetch: \(error.localizedDescription)")
			return []
		}
	}

	/// Method to fetch all `ManagedObject` of App Data Storage, sorted by creationDate
	func fetchAllMOsByCreationDate<MO: NSManagedObject>() -> [MO] {
		let request = NSFetchRequest<MO>(entityName: "ToDoMO")

		// Add sort descriptor to sort by creationDate in descending order (newest first)
		let sortDescriptor = NSSortDescriptor(key: "creationDate", ascending: false)
		request.sortDescriptors = [sortDescriptor]

		do {
			return try context.fetch(request)
		} catch {
			print("Failed to fetch: \(error.localizedDescription)")
			return []
		}
	}

	/// Method to get `ManagedObject` from Data Storage with needed ID
	private func fetchMOsWith<MO: NSManagedObject>(id: Int) -> MO? {
		let request = NSFetchRequest<MO>(entityName: "ToDoMO")
		request.predicate = NSPredicate(format: "id == %d", id)
		do {
			return try context.fetch(request).first
		} catch {
			print("Failed to fetch: \(error.localizedDescription)")
			return nil
		}
	}
}

// MARK: - CRUD for ToDoMOs

extension ToDoDataManager {

	/// Creates entity `ToDoMO` accordingly to`ToDo`
	func createToDoMO(_ toDo: ToDo) {
		let mo = ToDoMO(context: context)
		mo.id = Int64(toDo.id)
		mo.userId = Int64(toDo.userId)
		mo.todo = toDo.todo
		mo.completed = toDo.completed
		mo.taskDescription = toDo.taskDescription
		mo.deadline = toDo.deadline
		mo.creationDate = toDo.creationDate

		saveContext()
	}

	/// Returns `ToDos` from the Data Storage
	/// - Returns: an array of the `ToDo`s
	func fetchAllToDos() -> [ToDo] {
		let mos: [ToDoMO] = fetchAllMOs()
		return mos.map { ToDo($0) }
	}

	/// Returns `ToDos` from the Data Storage sorted by it's creation Date
	/// - Returns: an array of the `ToDo`s
	func fetchAllToDosByCreationDate() -> [ToDo] {
		let mos: [ToDoMO] = fetchAllMOsByCreationDate()
		return mos.map { ToDo($0) }
	}

	/// Method to get`ToDo`from Data Storage
	/// - Returns: a single ToDo
	func fetchToDo(withId id: Int) -> ToDo? {
		guard let mo = fetchMOsWith(id: id) as? ToDoMO else { return nil }
		return ToDo(mo)
	}

	/// Method to change `ToDoMO` accordingly to changes in `ToDo`
	/// - Parameter todo: current version of `ToDo`
	func updateToDo(_ todo: ToDo) {
		guard let mo = fetchMOsWith(id: todo.id) as? ToDoMO else { return }
		mo.id = Int64(todo.id)
		mo.todo = todo.todo
		mo.completed = todo.completed
		mo.userId = Int64(todo.userId)
		mo.taskDescription = todo.taskDescription
		mo.deadline = todo.deadline
		mo.creationDate = todo.creationDate
		saveContext()
	}

	/// Deletes a single `ToDo` from Data Storage
	/// - Parameter id: The identifier of the `ToDo` to delete
	func deleteToDo(withId id: Int) {
		guard let mo = fetchMOsWith(id: id) as? ToDoMO else { return }
		context.delete(mo)
		saveContext()
	}
	
	/// Remove all `ToDo`s from Data Storage
	private func deleteAllToDos() {
		let allToDos: [ToDoMO] = fetchAllMOs()
		allToDos.forEach { context.delete($0) }
		saveContext()
	}
}

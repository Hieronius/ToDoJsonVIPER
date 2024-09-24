import CoreData

/// Data Storage of the app
final class PersistentContainer {

	/// Computed property to access Data Sotrage
	private var container: NSPersistentContainer {
		let container = NSPersistentContainer(name: "ToDoDataModel")
		container.loadPersistentStores { _, error in
			if let error {
				fatalError(error.localizedDescription)
			}
		}
		return container
	}

	/// Context of the App Data Storage
	lazy var context = container.viewContext
}

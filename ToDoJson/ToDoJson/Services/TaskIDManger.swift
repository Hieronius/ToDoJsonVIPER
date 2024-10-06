import Foundation

/// Protocol to define a manager which creates a unique ID's for any new User's tasks
protocol TaskIDManagerProtocol: AnyObject {

	/// Static property to identify entity as as `singleton` class
	static var shared: Self { get }

	/// A number to start from in generating unique id's
	var lastUsedID: Int { get }

	/// Method to generate and save current ID's counter to `UserDefaults`
	func generateNewID() -> Int
}

/// Manager to define a unique id for each new tasks user creates
final class TaskIDManager: TaskIDManagerProtocol {

	/// Single instance of the Manager for being accecable from different parts of the app
	static let shared = TaskIDManager()

	/// A property to keep tracking what the lastest task's id it was and also to be sure we won't interfere to id's data from JSON file we parsed information from
	private(set) var lastUsedID: Int = 1000
	
	private init() {
		lastUsedID = UserDefaults.standard.integer(forKey: "lastUsedTaskID")
		
		if lastUsedID < 1000 {
			lastUsedID = 1000
		}
	}

	/// Method to keep track on the current task unique id's and savings it to the `UserDefaults`
	func generateNewID() -> Int {
		let newID = lastUsedID
		lastUsedID += 1
		
		UserDefaults.standard.set(lastUsedID, forKey: "lastUsedTaskID")
		
		return newID
	}
}

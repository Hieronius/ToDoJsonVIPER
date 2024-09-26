import Foundation

class TaskIDManager {
	static let shared = TaskIDManager()
	private var lastUsedID: Int = 1000

	private init() {
		// Load last used ID from persistent storage
		lastUsedID = UserDefaults.standard.integer(forKey: "lastUsedTaskID")

		// If lastUsedID is less than 1000, reset it to 1000
		if lastUsedID < 1000 {
			lastUsedID = 1000
		}
	}

	func generateNewID() -> Int {
		let newID = lastUsedID
		lastUsedID += 1

		// Save the last used ID to persistent storage
		UserDefaults.standard.set(lastUsedID, forKey: "lastUsedTaskID")

		return newID
	}
}

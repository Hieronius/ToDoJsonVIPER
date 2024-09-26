import Foundation

class TaskIDManager {
	static let shared = TaskIDManager()
	private var lastUsedID: Int = 1000

	private init() {
		lastUsedID = UserDefaults.standard.integer(forKey: "lastUsedTaskID")

		if lastUsedID < 1000 {
			lastUsedID = 1000
		}
	}

	func generateNewID() -> Int {
		let newID = lastUsedID
		lastUsedID += 1

		UserDefaults.standard.set(lastUsedID, forKey: "lastUsedTaskID")

		return newID
	}
}

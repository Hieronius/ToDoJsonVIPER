import XCTest
@testable import ToDoJson

class TaskIDManagerMock: TaskIDManager {
	var mockLastUsedID: Int = 1000

	override func generateNewID() -> Int {
		// Return a fixed ID for testing or increment as needed
		let newID = mockLastUsedID
		mockLastUsedID += 1
		return newID
	}

	// Optionally, you can add methods to reset or set the last used ID for testing purposes
	func resetLastUsedID(to value: Int) {
		mockLastUsedID = value
	}
}

import XCTest
@testable import ToDoJson

class UserManagerMock: UserManager {
	var mockUserId: Int?

	override var userId: Int? {
		get {
			return mockUserId
		}
		set {
			mockUserId = newValue
		}
	}

}



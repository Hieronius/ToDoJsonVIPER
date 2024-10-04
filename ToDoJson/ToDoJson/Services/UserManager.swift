import Foundation

/// Protocol to define the behaviour of UserManager service in the app
protocol UserManagerProtocol: AnyObject {

	/// Unique user identifier
	var userId: Int? { get }

	/// Method to generate unique user identifier
	func generateUniqueUserId() -> Int
}

/// Manager to generate a unique user id when app launches in first time or to return an existing one
final class UserManager: UserManagerProtocol {

	/// Singleton property of UserManager for single state access from any parts of the app
	static let shared = UserManager()

	/// Unique userId which should be generated in first running of the app
	private(set) var userId: Int?

	private init() {
		if let savedUserId = UserDefaults.standard.value(forKey: "userId") as? Int {
			userId = savedUserId
		} else {
			userId = generateUniqueUserId()
			if let userId = userId {
				UserDefaults.standard.set(userId, forKey: "userId")
			}
		}
	}

	/// Method to generate random unique userID when app has been launched at the first time and saving it to UserDefaults
	func generateUniqueUserId() -> Int {
		var randomUserId: Int
		repeat {
			randomUserId = Int.random(in: 10000...99999)
		} while UserDefaults.standard.value(forKey: "\(randomUserId)") != nil

		UserDefaults.standard.set(randomUserId, forKey: "\(randomUserId)")
		return randomUserId
	}
}

import Foundation

/// Manager to generate a unique user id when app launches in first time or to return an existing one
final class UserManager {
	static let shared = UserManager()
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

	private func generateUniqueUserId() -> Int {
		var randomUserId: Int
		repeat {
			randomUserId = Int.random(in: 10000...99999)
		} while UserDefaults.standard.value(forKey: "\(randomUserId)") != nil

		UserDefaults.standard.set(randomUserId, forKey: "\(randomUserId)")
		return randomUserId
	}
}

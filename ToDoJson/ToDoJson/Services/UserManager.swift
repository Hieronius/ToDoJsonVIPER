import Foundation

import Foundation

class UserManager {
	static let shared = UserManager()
	private(set) var userId: Int?

	private init() {
		// Load or generate user ID
		if let savedUserId = UserDefaults.standard.value(forKey: "userId") as? Int {
			userId = savedUserId
		} else {
			// Generate a unique user ID
			userId = generateUniqueUserId()
			// Store the generated user ID in UserDefaults
			if let userId = userId {
				UserDefaults.standard.set(userId, forKey: "userId")
			}
		}
	}

	private func generateUniqueUserId() -> Int {
		var randomUserId: Int
		repeat {
			// Generate a random 5-digit number
			randomUserId = Int.random(in: 10000...99999)
		} while UserDefaults.standard.value(forKey: "\(randomUserId)") != nil

		// Store the generated user ID in UserDefaults
		UserDefaults.standard.set(randomUserId, forKey: "\(randomUserId)")
		return randomUserId
	}
}

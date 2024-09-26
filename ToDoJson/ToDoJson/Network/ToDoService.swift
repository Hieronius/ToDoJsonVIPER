import Foundation

/// A special service to handle and fetch and get `Tasks` from JSON file
class ToDoService {
	private let urlString = "https://dummyjson.com/todos"

	/// Method to get tasks from JSON
	/// - Parameter completion: the result of fetching the JSON file
	func fetchTasks(completion: @escaping (Result<[ToDo], Error>) -> Void) {
		guard let url = URL(string: urlString) else {
			completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
			return
		}

		DispatchQueue.global(qos: .utility).async {
			let task = URLSession.shared.dataTask(with: url) { data, response, error in
				if let error = error {
					DispatchQueue.main.async {
						completion(.failure(error))
					}
					return
				}

				guard let data else {
					DispatchQueue.main.async {
						completion(.failure(NSError(domain: "No data", code: 0, userInfo: nil)))
					}
					return
				}

				do {
					let todoResponse = try JSONDecoder().decode(ToDoResponse.self, from: data)
					DispatchQueue.main.async {
						completion(.success(todoResponse.todos))
					}
				} catch {
					DispatchQueue.main.async {
						completion(.failure(error))
					}
				}
			}
			task.resume()
		}
	}
}

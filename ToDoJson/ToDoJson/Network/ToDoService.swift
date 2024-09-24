import Foundation

/// A special service to handle and fetch and get `Tasks` from JSON file
final class ToDoService {

	/// Method to get tasks from local JSON file
	/// - Parameter completion: the result of fetching the JSON file
	func fetchTasks(completion: @escaping (Result<[ToDo], Error>) -> Void) {

		if let resourcePath = Bundle.main.resourcePath {
					do {
						let files = try FileManager.default.contentsOfDirectory(atPath: resourcePath)
						print("Available resources: \(files)")
					} catch {
						print("Failed to list resources: \(error)")
					}
				}

		
		guard let url = Bundle.main.url(forResource: "tasks", withExtension: "json") else {
			completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
			return
		}
		do {
			let data = try Data(contentsOf: url)
			let decoder = JSONDecoder()

			// Decode only the "todos" array from the JSON data
			if let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
			   let todosArray = jsonObject["todos"] as? [[String: Any]] {

				// Convert the array of dictionaries to Data
				let todosData = try JSONSerialization.data(withJSONObject: todosArray, options: [])

				// Decode the Data into an array of ToDo objects
				let todos = try decoder.decode([ToDo].self, from: todosData)
				completion(.success(todos))
			} else {
				completion(.failure(NSError(domain: "Invalid JSON structure", code: 0, userInfo: nil)))
			}
		} catch {
			completion(.failure(error))
		}
	}
}

///// A special service to handle and fetch and get `Tasks` from JSON file
//final class ToDoService {
//	private let urlString = "https://dummyjson.com/todos"
//
//	
//	/// Method to get tasks from JSON
//	/// - Parameter completion: the result of fetching the JSON file
//	func fetchTasks(completion: @escaping (Result<[ToDo], Error>) -> Void) {
//		guard let url = URL(string: urlString) else {
//			completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
//			return
//		}
//
//		let task = URLSession.shared.dataTask(with: url) { data, response, error in
//			if let error = error {
//				completion(.failure(error))
//				return
//			}
//
//			guard let data else {
//				completion(.failure(NSError(domain: "No data", code: 0, userInfo: nil)))
//				return
//			}
//
//			do {
//				let todos = try JSONDecoder().decode([ToDo].self, from: data)
//				completion(.success(todos))
//			} catch {
//				completion(.failure(error))
//			}
//		}
//		task.resume()
//	}
//}
//
// // Usage
//let todoService = ToDoService()
//todoService.fetchTasks { result in
//	switch result {
//	case .success(let todos):
//		print("Fetched Todos: \(todos)")
//	case .failure(let error):
//		print("Error fetching todos: \(error)")
//	}
//}

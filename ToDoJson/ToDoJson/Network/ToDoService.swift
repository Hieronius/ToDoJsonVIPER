import Foundation

/// A special service to handle and fetch and get `Tasks` from JSON file
final class ToDoService {

	// MARK: - Private Properties

	private let urlString = "https://dummyjson.com/todos"

	// MARK: - Public Methods

	/// Fetches tasks from a remote source.
	///
	/// This method constructs a URL from a predefined string and initiates a network request
	/// to retrieve a list of tasks. It uses `URLSession` to perform the request asynchronously.
	/// The results are returned via a completion handler, which provides either an array of
	/// `ToDo` objects on success or an error on failure.
	///
	/// - Parameter completion: A closure that takes a `Result` containing either an array of
	///   `ToDo` objects or an `Error`. The closure is called on the main thread with the result
	///   of the fetch operation.
	///
	/// - Note: This method handles errors related to invalid URLs, network issues, and JSON decoding.
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

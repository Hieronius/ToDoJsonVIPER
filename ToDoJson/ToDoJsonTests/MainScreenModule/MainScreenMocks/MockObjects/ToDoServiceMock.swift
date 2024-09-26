import XCTest
@testable import ToDoJson

class ToDoServiceMock: ToDoService {
	var shouldReturnError = false

	override func fetchTasks(completion: @escaping (Result<[ToDo], Error>) -> Void) {
		if shouldReturnError {
			completion(.failure(NSError(domain: "TestError", code: 1, userInfo: nil)))
		} else {
			let tasks = [
				ToDo(id: 1, todo: "Task 1", completed: false, userId: 1),
				ToDo(id: 2, todo: "Task 2", completed: true, userId: 1)
			]
			completion(.success(tasks))
		}
	}
}

import XCTest
@testable import ToDoJson

class MainScreenInteractorTests: XCTestCase {
	var interactor: MainScreenInteractor!
	var presenterMock: MainScreenPresenterMock!
	var todoServiceMock: ToDoServiceMock!

	override func setUp() {
		super.setUp()
		todoServiceMock = ToDoServiceMock()
		interactor = MainScreenInteractor(todoService: todoServiceMock)
		presenterMock = MainScreenPresenterMock()
		interactor.presenter = MainScreenPresenter()
	}

	override func tearDown() {
		interactor = nil
		presenterMock = nil
		todoServiceMock = nil
		super.tearDown()
	}

	func testLoadTasksWhenCoreDataIsEmpty() {
		let dataManagerMock = ToDoDataManagerMock()
		dataManagerMock.tasks = []

		interactor.loadTasks()

		let expectation = self.expectation(description: "Loading tasks")

		DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
			XCTAssertTrue(self.presenterMock.showTasksCalled, "Expected showTasks to be called")
			XCTAssertEqual(self.presenterMock.tasks.count, 2, "Expected two tasks to be returned")
			expectation.fulfill()
		}

		waitForExpectations(timeout: 1.0, handler: nil)
	}

	func testLoadTasksWhenCoreDataHasTasks() {
		let dataManagerMock = ToDoDataManagerMock()
		dataManagerMock.tasks = [
			ToDo(id: 3, todo: "Existing Task", completed: false, userId: 1)
		]

		interactor.loadTasks()

		let expectation = self.expectation(description: "Loading tasks")

		DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
			XCTAssertTrue(self.presenterMock.showTasksCalled, "Expected showTasks to be called")
			XCTAssertEqual(self.presenterMock.tasks.count, 1, "Expected one task to be returned from Core Data")
			expectation.fulfill()
		}

		waitForExpectations(timeout: 1.0, handler: nil)
	}

	func testParseTasksSuccess() {
		todoServiceMock.shouldReturnError = false

		let expectation = self.expectation(description: "Parsing tasks")

		interactor.parseTasks { todos in
			XCTAssertEqual(todos.count, 2, "Expected two tasks to be parsed")
			XCTAssertEqual(todos.first?.todo, "Task 1", "Expected first task's title to be 'Task 1'")
			expectation.fulfill()
		}

		waitForExpectations(timeout: 1.0, handler: nil)
	}

	func testParseTasksFailure() {
		todoServiceMock.shouldReturnError = true

		let expectation = self.expectation(description: "Parsing tasks with error")

		interactor.parseTasks { todos in
			XCTAssertEqual(todos.count, 0, "Expected no tasks to be parsed on error")
			expectation.fulfill()
		}

		waitForExpectations(timeout: 1.0, handler: nil)
	}

	func testFilterTasksByCategory() {
		 let dataManagerMock = ToDoDataManagerMock()
		 dataManagerMock.tasks = [
			 ToDo(id: 4, todo: "Completed Task", completed: true, userId: 1),
			 ToDo(id: 5, todo: "Uncompleted Task", completed: false, userId: 1)
		 ]


		 let allTasks = interactor.filterTasks(by: .all)
		 XCTAssertEqual(allTasks.count, 2)

		 let completedTasks = interactor.filterTasks(by: .completed)
		 XCTAssertEqual(completedTasks.count, 1)

		 let uncompletedTasks = interactor.filterTasks(by: .uncompleted)
		 XCTAssertEqual(uncompletedTasks.count, 1)
	 }
}

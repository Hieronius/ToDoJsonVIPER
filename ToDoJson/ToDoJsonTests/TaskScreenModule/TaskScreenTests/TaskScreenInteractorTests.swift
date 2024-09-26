import XCTest
@testable import ToDoJson

class TaskScreenInteractorTests: XCTestCase {

	var taskScreenInteractor: TaskScreenInteractor!
	var mockPresenter: TaskScreenPresenter!
	var mockUserManager: UserManagerMock!
	var mockTaskIDManager: TaskIDManagerMock!

	override func setUp() {
		super.setUp()
		taskScreenInteractor = TaskScreenInteractor()
		mockPresenter = TaskScreenPresenter()
		mockUserManager = UserManagerMock()
		mockTaskIDManager = TaskIDManagerMock()

		taskScreenInteractor.presenter = mockPresenter
		taskScreenInteractor.setUserManager(mockUserManager)
		taskScreenInteractor.setTaskIDManager(mockTaskIDManager)
	}

	override func tearDown() {
		taskScreenInteractor = nil
		mockPresenter = nil
		mockUserManager = nil
		mockTaskIDManager = nil
		super.tearDown()
	}

	// Test to ensure createTask creates a new task correctly
	func testCreateTaskCreatesNewTask() {
		// Given
		mockUserManager.userId = 12345 // Simulate a user ID
		mockTaskIDManager.mockLastUsedID = 1001 // Simulate generated task ID
		

		let title = "Test Task"
		let description = "Test Description"
		let deadline = Date()

		// When
		taskScreenInteractor.createTask(title: title, description: description, deadline: deadline, creationDate: Date())

		// Then
		XCTAssertEqual(ToDoDataManager.shared.fetchAllToDos().count, 1, "There should be one task created.")

		let createdTask = ToDoDataManager.shared.fetchAllToDos().first

		XCTAssertEqual(createdTask?.todo, title, "The task title should match.")
		XCTAssertEqual(createdTask?.taskDescription, description, "The task description should match.")
		XCTAssertEqual(createdTask?.userId, 12345, "The user ID should match.")
	}

	// Test to ensure updateTask updates an existing task correctly
	func testUpdateTaskUpdatesExistingTask() {
		// Given
		var existingTask = ToDo(id: 1000, todo: "Existing Task", completed: false, userId: 12345, taskDescription: "Existing Description", deadline: Date(), creationDate: Date())

		// Simulate adding the existing task to the data manager
		ToDoDataManager.shared.createToDoMO(existingTask)

		// When
		existingTask.todo = "Updated Task"
		taskScreenInteractor.updateTask(existingTask)

		// Then
		let updatedTasks = ToDoDataManager.shared.fetchAllToDos()

		XCTAssertEqual(updatedTasks.count, 1, "There should still be one task.")

		let updatedTask = updatedTasks.first

		XCTAssertEqual(updatedTask?.todo, "Updated Task", "The task title should be updated.")
	}
}

import XCTest
@testable import ToDoJson

	class TaskScreenPresenterTests: XCTestCase {

		var presenter: TaskScreenPresenter!
		var mockView: TaskScreenViewControllerInputMock!
		var mockInteractor: TaskScreenInteractorMock!
		var mockRouter: TaskScreenRouterMock!

		override func setUp() {
			super.setUp()
			presenter = TaskScreenPresenter()
			mockView = TaskScreenViewControllerInputMock()
			mockInteractor = TaskScreenInteractorMock()
			mockRouter = TaskScreenRouterMock()

			presenter.view = mockView
			presenter.interactor = mockInteractor
			presenter.router = mockRouter
		}

		override func tearDown() {
			presenter = nil
			mockView = nil
			mockInteractor = nil
			mockRouter = nil
			super.tearDown()
		}

		func testSaveTaskCallsInteractorCreateTask() {
			let title = "New Task"
			let description = "New Description"
			let deadline = Date()

			presenter.saveTask(title: title, description: description, deadline: deadline, creationDate: Date())

			XCTAssertTrue(mockInteractor.createTaskCalled, "saveTask should call interactor's createTask method")
			XCTAssertEqual(mockInteractor.createdTaskTitle, title, "Interactor should receive the correct task title")
			XCTAssertEqual(mockInteractor.createdTaskDescription, description, "Interactor should receive the correct task description")
		}

		func testUpdateTaskCallsInteractorUpdateTask() {
			let existingTask = ToDo(id: 1, todo: "Existing Task", completed: false, userId: 1, taskDescription: "Existing Description", deadline: Date(), creationDate: Date())

			presenter.updateTask(existingTask, title: "Updated Task", isCompleted: true, description: "Updated Description", deadline: Date(), creationDate: Date())

			XCTAssertTrue(mockInteractor.updateTaskCalled, "updateTask should call interactor's updateTask method")
			XCTAssertEqual(mockInteractor.updatedTask?.todo, "Updated Task", "Updated task title should be sent to interactor")
		}

		func testSaveTaskNavigatesBack() {
			presenter.saveTask(title: "New Task", description: nil, deadline: nil, creationDate: nil)

			XCTAssertTrue(mockRouter.navigateBackCalled, "saveTask should navigate back after saving")
		}

		func testUpdateTaskNavigatesBack() {
			let existingTask = ToDo(id: 1, todo: "Existing Task", completed: false, userId: 1, taskDescription: "Existing Description", deadline: Date(), creationDate: Date())

			presenter.updateTask(existingTask, title: "Updated Task", isCompleted: true, description: nil, deadline: nil, creationDate: nil)

			XCTAssertTrue(mockRouter.navigateBackCalled, "updateTask should navigate back after updating")
		}
	}

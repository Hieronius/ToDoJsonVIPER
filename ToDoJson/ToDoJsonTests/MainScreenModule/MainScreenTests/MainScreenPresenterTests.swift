import XCTest
@testable import ToDoJson

class MainScreenPresenterTests: XCTestCase {
	var presenter: MainScreenPresenter!
	var viewMock: MainScreenViewInputMock!
	var interactorMock: MainScreenInteractorProtocolMock!
	var routerMock: MainScreenRouterProtocolMock!

	override func setUp() {
		super.setUp()
		presenter = MainScreenPresenter()
		viewMock = MainScreenViewInputMock()
		interactorMock = MainScreenInteractorProtocolMock()
		routerMock = MainScreenRouterProtocolMock()

		presenter.view = viewMock
		presenter.interactor = interactorMock
		presenter.router = routerMock
	}

	override func tearDown() {
		presenter = nil
		viewMock = nil
		interactorMock = nil
		routerMock = nil
		super.tearDown()
	}

	func testViewDidLoadCallsLoadTasksAndSelectsAllCategory() {
		presenter.viewDidLoad()

		XCTAssertTrue(interactorMock.loadTasksCalled, "Expected loadTasks to be called")

		presenter.selectCategory(.all)

		XCTAssertTrue(viewMock.updateCategoryColorsCalled, "Expected updateCategoryColors to be called")

		interactorMock.filterTasksReturnValue = [ToDo(id: 1, todo: "Test Task", completed: false, userId: 1)]

		presenter.selectCategory(.all)

		XCTAssertTrue(viewMock.displayFilteredTasksCalled, "Expected displayFilteredTasks to be called")
		XCTAssertEqual(viewMock.displayedFilteredTasks.count, 1)
		XCTAssertEqual(viewMock.displayedFilteredTasks.first?.todo, "Test Task")
	}

	func testNewTaskButtonTappedCallsRouter() {
		presenter.newTaskButtonTapped()

		XCTAssertTrue(routerMock.navigateToTaskScreenCalled, "Expected navigateToTaskScreen to be called")
	}

	func testEditTaskCallsRouter() {
		let todo = ToDo(id: 1, todo: "Test Task", completed: false, userId: 1)

		presenter.editTask(todo)

		XCTAssertTrue(routerMock.navigateToEditTaskCalled, "Expected navigateToEditTask to be called")
		XCTAssertEqual(routerMock.editedTask?.id, todo.id, "Expected edited task ID to match")
	}

	func testShowTasksUpdatesAllTasksAndDisplays() {
		let tasks = [ToDo(id: 1, todo: "Test Task", completed: false, userId: 1)]

		presenter.showTasks(tasks)

		XCTAssertEqual(presenter.allTasks.count, 1)
		XCTAssertEqual(presenter.allTasks.first?.todo, "Test Task")

		XCTAssertTrue(viewMock.displayTasksCalled, "Expected displayTasks to be called")
		XCTAssertEqual(viewMock.displayedTasks.count, 1)
		XCTAssertEqual(viewMock.displayedTasks.first?.todo, "Test Task")
	}

	func testShowFilteredTasksUpdatesFilteredTasksAndDisplays() {
		let tasks = [ToDo(id: 2, todo: "Test Task 2", completed: true, userId: 1)]

		presenter.showFilteredTasks(tasks)

		XCTAssertEqual(presenter.filteredTasks.count, 1)
		XCTAssertEqual(presenter.filteredTasks.first?.todo, "Test Task 2")

		XCTAssertTrue(viewMock.displayFilteredTasksCalled, "Expected displayFilteredTasks to be called")
		XCTAssertEqual(viewMock.displayedFilteredTasks.count, 1)
		XCTAssertEqual(viewMock.displayedFilteredTasks.first?.todo, "Test Task 2")
	}

	func testSelectCategoryFiltersAndUpdatesColors() {
		let category = Category.uncompleted

		interactorMock.filterTasksReturnValue = [ToDo(id: 3, todo: "Uncompleted Task", completed: false, userId: 1)]

		presenter.selectCategory(category)

	   XCTAssertTrue(viewMock.displayFilteredTasksCalled)
	   XCTAssertEqual(viewMock.displayedFilteredTasks.count, 1)

	   XCTAssertTrue(viewMock.updateCategoryColorsCalled)
   }
}

import XCTest
@testable import ToDoJson

class MainScreenViewTests: XCTestCase {
	var mainScreenView: MainScreenView!

	override func setUp() {
		super.setUp()
		mainScreenView = MainScreenView(frame: CGRect(x: 0, y: 0, width: 375, height: 667))
		mainScreenView.layoutIfNeeded()
	}

	override func tearDown() {
		mainScreenView = nil
		super.tearDown()
	}

	func testNewTaskButtonInitialization() {
		XCTAssertNotNil(mainScreenView.newTaskButton)
		XCTAssertEqual(mainScreenView.newTaskButton.title(for: .normal), "  + New Task  ")
	}

	func testCategoriesContainerViewInitialization() {
		XCTAssertNotNil(mainScreenView.categoriesContainerView)
	}

	func testCollectionViewInitialization() {
		XCTAssertNotNil(mainScreenView.collectionView)
		XCTAssertEqual(mainScreenView.collectionView.backgroundColor, .clear)
	}

	func testCategoryLabelsInitialization() {
		XCTAssertNotNil(mainScreenView.categoryAllNameLabel)
		XCTAssertEqual(mainScreenView.categoryAllNameLabel.text, "All")

		XCTAssertNotNil(mainScreenView.categoryOpenNameLabel)
		XCTAssertEqual(mainScreenView.categoryOpenNameLabel.text, "Open")

		XCTAssertNotNil(mainScreenView.categoryClosedNameLabel)
		XCTAssertEqual(mainScreenView.categoryClosedNameLabel.text, "Closed")
	}
}

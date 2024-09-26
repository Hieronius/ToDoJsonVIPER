import UIKit

/// Protocol that defines the interface for the View to communicate with the Presenter.
///
/// The `MainScreenViewInput` protocol is implemented by the View (e.g., `MainScreenViewController`)
/// to receive updates from the Presenter. It provides methods for displaying tasks,
/// filtered tasks, and updating UI elements based on selected categories.
protocol MainScreenViewInput: AnyObject {
	
	/// Displays a list of tasks in the view.
	///
	/// - Parameter tasks: An array of `ToDo` objects representing tasks to be displayed.
	func displayTasks(_ tasks: [ToDo])
	
	/// Displays a filtered list of tasks in the view.
	///
	/// - Parameter tasks: An array of `ToDo` objects representing the filtered tasks to be displayed.
	func displayFilteredTasks(_ tasks: [ToDo])
	
	
	/// Updates the UI to reflect the colors associated with the selected category.
	///
	/// - Parameter selectedCategory: The category that has been selected by the user,
	/// which will determine how the UI elements are colored.
	func updateCategoryColors(selectedCategory: Category)
}

/// Protocol that defines the interface for the View to communicate user actions to the Presenter.
///
/// The `MainScreenViewOutput` protocol is implemented by the Presenter (e.g., `MainScreenPresenter`)
/// to handle user interactions from the View. It provides methods for responding to user actions
/// such as creating new tasks, editing existing tasks, selecting categories, and handling view lifecycle events.
protocol MainScreenViewOutput: AnyObject {
	
	/// Called when the user taps on the button to create a new task.
	func newTaskButtonTapped()
	
	/// Called when a task needs to be edited.
	///
	/// - Parameter todo: The `ToDo` object representing the task that is to be edited.
	func editTask(_ todo: ToDo)
	
	/// Called when a category is selected by the user.
	///
	/// - Parameter category: The `Category` object representing the category that has been selected.
	func selectCategory(_ category: Category)
}

/// Controller for the `MainScreen`
final class MainScreenViewController: GenericViewController<MainScreenView> {
	
	// MARK: - Public Properties
	
	/// Owns presenter by strong reference
	var presenter: MainScreenPresenterProtocol?
	
	// MARK: - Private Properties
	
	private var allTasks: [ToDo] = []
	private var filteredTasks: [ToDo] = []
	
	private var dataSource: UICollectionViewDiffableDataSource<Int, ToDo>!
	
	// MARK: - Life Cycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureDataSource()
		setupBehaviour()
		configureCollectionView()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		presenter?.viewDidLoad()
		updateSnapshot()
	}
}

// MARK: - SetupBehaviour

extension MainScreenViewController {
	private func setupBehaviour() {
		rootView.collectionView.delegate = self
		
		rootView.newTaskButton.addTarget(self, action: #selector(moveToTaskScreen), for: .touchUpInside)
		
		setupCategoryGestures()
	}
	
	@objc
	func moveToTaskScreen() {
		presenter?.newTaskButtonTapped()
	}
}

// MARK: - Adding gestures to the categories

private extension MainScreenViewController {
	
	/// Makes categories of the tasks clickable
	func setupCategoryGestures() {
		let allTapGesture = UITapGestureRecognizer(target: self, action: #selector(showAllTasks))
		rootView.categoryAllSummeryStackView.addGestureRecognizer(allTapGesture)
		
		let openTapGesture = UITapGestureRecognizer(target: self, action: #selector(showUncompletedTasks))
		rootView.categoryOpenSummeryStackView.addGestureRecognizer(openTapGesture)
		
		let closedTapGesture = UITapGestureRecognizer(target: self, action: #selector(showCompletedTasks))
		rootView.categoryClosedSummeryStackView.addGestureRecognizer(closedTapGesture)
	}
}

// MARK: - Categories Filtering Logic

extension MainScreenViewController {
	
	/// Called to display all tasks.
	@objc func showAllTasks() {
		presenter?.selectCategory(.all)
	}
	
	/// Called to display only completed tasks.
	@objc func showCompletedTasks() {
		presenter?.selectCategory(.completed)
	}
	
	/// Called to display only uncompleted tasks.
	@objc func showUncompletedTasks() {
		presenter?.selectCategory(.uncompleted)
	}
	
	/// Updates the task count labels for each category in the UI.
	func updateCategoryTaskCounts() {
		rootView.categoryAllTaskCountLabel.text = "\(allTasks.count)"
		rootView.categoryOpenTaskCountLabel.text = "\(allTasks.filter { !$0.completed }.count)"
		rootView.categoryClosedTaskCountLabel.text = "\(allTasks.filter { $0.completed }.count)"
	}
	
	/// Highlights the selected category of tasks by updating label colors.
	func updateCategoryColors(selectedCategory: Category) {
		switch selectedCategory {
		case .all:
			rootView.categoryAllNameLabel.textColor = .blue
			rootView.categoryAllTaskCountLabel.textColor = .blue
			rootView.categoryOpenNameLabel.textColor = .gray
			rootView.categoryOpenTaskCountLabel.textColor = .gray
			rootView.categoryClosedNameLabel.textColor = .gray
			rootView.categoryClosedTaskCountLabel.textColor = .gray
			
		case .uncompleted:
			rootView.categoryAllNameLabel.textColor = .gray
			rootView.categoryAllTaskCountLabel.textColor = .gray
			rootView.categoryOpenNameLabel.textColor = .blue
			rootView.categoryOpenTaskCountLabel.textColor = .blue
			rootView.categoryClosedNameLabel.textColor = .gray
			rootView.categoryClosedTaskCountLabel.textColor = .gray
			
		case .completed:
			rootView.categoryAllNameLabel.textColor = .gray
			rootView.categoryAllTaskCountLabel.textColor = .gray
			rootView.categoryOpenNameLabel.textColor = .gray
			rootView.categoryOpenTaskCountLabel.textColor = .gray
			rootView.categoryClosedNameLabel.textColor = .blue
			rootView.categoryClosedTaskCountLabel.textColor = .blue
		}
	}
}

// MARK: - Collection View Setup

private extension MainScreenViewController {
	
	/// Methods adds `Delete` and `Edit` actions to the cells
	func configureCollectionView() {
		var config = UICollectionLayoutListConfiguration(appearance: .plain)
		config.trailingSwipeActionsConfigurationProvider = { [unowned self] indexPath in
			
			guard let todo = self.dataSource.itemIdentifier(for: indexPath) else { return UISwipeActionsConfiguration(actions: []) }
			
			let editAction = UIContextualAction(style: .normal, title: "Edit") { action, view, completionHandler in
				self.presenter?.editTask(todo)
				completionHandler(true)
			}
			editAction.backgroundColor = .systemBlue
			
			let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { action, view, completionHandler in
				
				DispatchQueue.global(qos: .userInitiated).async {
					if let index = self.allTasks.firstIndex(where: { $0.id == todo.id }) {
						self.allTasks.remove(at: index)
					}
					
					ToDoDataManager.shared.deleteToDo(withId: todo.id)
					
					DispatchQueue.main.async {
						var snapshot = self.dataSource.snapshot()
						snapshot.deleteItems([todo])
						self.dataSource.apply(snapshot, animatingDifferences: true)
						self.updateCategoryTaskCounts()
						completionHandler(true)
					}
				}
			}
			return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
		}
		config.backgroundColor = .clear
		config.showsSeparators = false
		
		let layout = UICollectionViewCompositionalLayout.list(using: config)
		rootView.collectionView.setCollectionViewLayout(layout, animated: false)
	}
}

// MARK: - Setup DiffableDataSource

extension MainScreenViewController {
	
	private func configureDataSource() {
		dataSource = UICollectionViewDiffableDataSource<Int, ToDo>(collectionView: rootView.collectionView) { (collectionView, indexPath, todo) -> UICollectionViewCell? in
			guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ToDoCell.reuseIdentifier, for: indexPath) as? ToDoCell else {
				fatalError("Cannot create new cell")
			}
			cell.configure(with: todo)
			return cell
		}
	}
	
	private func updateSnapshot() {
		var snapshot = NSDiffableDataSourceSnapshot<Int, ToDo>()
		snapshot.appendSections([0])
		snapshot.appendItems(allTasks)
		dataSource.apply(snapshot, animatingDifferences: true)
		
		updateCategoryTaskCounts()
	}
	
	/// Apply changes on the screen when you use trailing swipe gesture on the cell
	func applySnapshot(with tasks: [ToDo]) {
		var snapshot = NSDiffableDataSourceSnapshot<Int, ToDo>()
		snapshot.appendSections([0])
		snapshot.appendItems(tasks)
		dataSource.apply(snapshot, animatingDifferences: true)
	}
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MainScreenViewController: UICollectionViewDelegateFlowLayout {
	
	/// Called when a user selects an item in the collection view.
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		if allTasks[indexPath.item].completed {
			allTasks[indexPath.item].completed = false
		} else if !allTasks[indexPath.item].completed {
			allTasks[indexPath.item].completed = true
		}
		updateSnapshot()
		updateCategoryTaskCounts()
		ToDoDataManager.shared.updateToDo(allTasks[indexPath.item])
	}
	
	/// Returns the size for each item in the collection view.
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: collectionView.bounds.width - 20, height: 300)
	}
}

// MARK: - MainScreenViewInput
extension MainScreenViewController: MainScreenViewInput {
	
	/// Displays a list of tasks in the view.
	///
	/// - Parameter tasks: An array of `ToDo` objects representing the tasks to be displayed.
	func displayTasks(_ tasks: [ToDo]) {
		allTasks = tasks
		applySnapshot(with: tasks)
		updateCategoryTaskCounts()
	}
	
	/// Displays a filtered list of tasks in the view.
	///
	/// - Parameter tasks: An array of `ToDo` objects representing the filtered tasks to be displayed.
	func displayFilteredTasks(_ tasks: [ToDo]) {
		filteredTasks = tasks
		applySnapshot(with: tasks)
		updateCategoryTaskCounts()
	}
}

// MARK: - MainScreenViewOutput

extension MainScreenViewController: MainScreenViewOutput {
	
	/// Called when the user taps the button to create a new task.
	func newTaskButtonTapped() {
		presenter?.newTaskButtonTapped() // Call method on presenter
	}
	
	/// Called when a task needs to be edited.
	///
	/// - Parameter todo: The `ToDo` object representing the task that is to be edited.
	func editTask(_ todo: ToDo) {
		presenter?.editTask(todo) // Call method on presenter to edit task
	}
	
	/// Called when a category of the tasks is selected by the user.
	///
	/// - Parameter category: The `Category` object representing the selected category.
	func selectCategory(_ category: Category) {
		presenter?.selectCategory(category) // Call method on presenter to select category
	}
}

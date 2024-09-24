import UIKit

/// Controller for the `MainScreen`
final class MainScreenViewController: GenericViewController<MainScreenView> {

	var presenter: MainScreenPresenterProtocol?
	
	private var dataSource: UICollectionViewDiffableDataSource<Int, ToDo>!

	private var allTasks: [ToDo] = []
	private var filteredTasks: [ToDo] = []

	// MARK: - Life Cycle

	override func viewDidLoad() {
		super.viewDidLoad()
		configureDataSource()
		setupBehaviour()
		configureCollectionView()

	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		presenter?.viewDidLoad() // Fetch tasks each time the view appears
	}


	// MARK: - Collection View Setup

	private func configureCollectionView() {
		   // Create a list layout configuration
		var config = UICollectionLayoutListConfiguration(appearance: .plain)

		   // Add delete action on swipe
		   config.trailingSwipeActionsConfigurationProvider = { [unowned self] indexPath in
			   let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { action, view, completionHandler in
				   if let todo = self.dataSource.itemIdentifier(for: indexPath) {
					   ToDoDataManager.shared.deleteToDo(withId: todo.id)
					   var snapshot = self.dataSource.snapshot()
					   snapshot.deleteItems([todo])
					   self.dataSource.apply(snapshot, animatingDifferences: true)
				   }
				   completionHandler(true)
			   }
			   return UISwipeActionsConfiguration(actions: [deleteAction])
		   }

		// Setup appearance of the config
		config.backgroundColor = .clear
		config.showsSeparators = false


		// Initialize the collection view with the list layout
				let layout = UICollectionViewCompositionalLayout.list(using: config)



		rootView.collectionView.setCollectionViewLayout(layout, animated: false)
	   }

}

// MARK: Update Tasks

extension MainScreenViewController {
	func showTasks(_ tasks: [ToDo]) {
		allTasks = tasks
		applySnapshot(with: tasks)
		updateCategoryTaskCounts()
	}

	func showFilteredTasks(_ tasks: [ToDo]) {
		filteredTasks = tasks
		applySnapshot(with: tasks)
		updateCategoryTaskCounts()
	}
}

// MARK: - Setup DiffableDataSource

private extension MainScreenViewController {
	func configureDataSource() {
		dataSource = UICollectionViewDiffableDataSource<Int, ToDo>(collectionView: rootView.collectionView) { (collectionView, indexPath, todo) -> UICollectionViewCell? in
			guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ToDoCell.reuseIdentifier, for: indexPath) as? ToDoCell else {
				fatalError("Cannot create new cell")
			}
			cell.configure(with: todo)
			return cell
		}
	}

	// Create and apply a new snapshot
	func updateSnapshot() {
		var snapshot = NSDiffableDataSourceSnapshot<Int, ToDo>()
		snapshot.appendSections([0])
		snapshot.appendItems(allTasks)
		dataSource.apply(snapshot, animatingDifferences: true)

		updateCategoryTaskCounts()
	}
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MainScreenViewController: UICollectionViewDelegateFlowLayout {

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		allTasks[indexPath.item].completed.toggle()
		ToDoDataManager.shared.updateToDo(allTasks[indexPath.item])
		updateSnapshot()
		updateCategoryTaskCounts()
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
			return CGSize(width: collectionView.bounds.width - 20, height: 300) // Adjust height as needed
		}
}

// MARK: - SetupBehaviour

extension MainScreenViewController {
	func setupBehaviour() {
		rootView.collectionView.delegate = self

		rootView.newTaskButton.addTarget(self, action: #selector(moveToTaskScreen), for: .touchUpInside)

		setupCategoryGestures()
	}

	@objc
	func moveToTaskScreen() {
		presenter?.newTaskButtonTapped()
	}

}

// MARK: - Categories logic

extension MainScreenViewController {
	@objc func showAllTasks() {
		presenter?.selectCategory(.all)
	}

	@objc func showCompletedTasks() {
		presenter?.selectCategory(.completed)
	}

	@objc func showUncompletedTasks() {
		presenter?.selectCategory(.uncompleted)
	}

	func applySnapshot(with tasks: [ToDo]) {
		var snapshot = NSDiffableDataSourceSnapshot<Int, ToDo>()
		snapshot.appendSections([0])
		snapshot.appendItems(tasks)
		dataSource.apply(snapshot, animatingDifferences: true)
	}

	func updateCategoryTaskCounts() {
		rootView.categoryAllTaskCountLabel.text = "\(allTasks.count)"
		rootView.categoryOpenTaskCountLabel.text = "\(allTasks.filter { !$0.completed }.count)"
		rootView.categoryClosedTaskCountLabel.text = "\(allTasks.filter { $0.completed }.count)"
	}

	/// Method to highlight a selected category of tasks
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

// MARK: - Adding gestures to the categories

private extension MainScreenViewController {
	func setupCategoryGestures() {
		let allTapGesture = UITapGestureRecognizer(target: self, action: #selector(showAllTasks))
		rootView.categoryAllSummeryStackView.addGestureRecognizer(allTapGesture)

		let openTapGesture = UITapGestureRecognizer(target: self, action: #selector(showUncompletedTasks))
		rootView.categoryOpenSummeryStackView.addGestureRecognizer(openTapGesture)

		let closedTapGesture = UITapGestureRecognizer(target: self, action: #selector(showCompletedTasks))
		rootView.categoryClosedSummeryStackView.addGestureRecognizer(closedTapGesture)
	}
}

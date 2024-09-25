import UIKit

/// RootView for the `MainScreen`
final class MainScreenView: UIView {

	// MARK: - Private Properties

	let mainVerticalStackView = UIStackView()

	// MARK: Header

	private let headerContainerView = UIView()
	private let headerVerticalStackView = UIStackView()
	private let headerHorizontalStackView = UIStackView()
	private let headerTitle = UILabel()
	private let headerSubTitle = UILabel()
	private let spacer = UIView()

	/// Button `New Task` on the Main Screen
	let newTaskButton = UIButton()

	// MARK: Categories of the tasks

	let categoriesContainerView = UIView()
	let categoriesHorizontalStackView = UIStackView()

	let categoryAllSummeryStackView = UIStackView()
	let categoryAllNameLabel = UILabel()
	let categoryAllTaskCountLabel = UILabel()

	let pipeSeparatorView = UILabel()

	let categoryOpenSummeryStackView = UIStackView()
	let categoryOpenNameLabel = UILabel()
	let categoryOpenTaskCountLabel = UILabel()
	
	let categoryClosedSummeryStackView = UIStackView()
	let categoryClosedNameLabel = UILabel()
	let categoryClosedTaskCountLabel = UILabel()

	// MARK: Tasks

	/// `CollectionView` to display the list of tasks
	let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())


	// MARK: - Initialization

	override init(frame: CGRect) {
		super.init(frame: frame)
		embedViews()
		setupAppearance()
		setupLayout()
		setupData()
	}

	@available(*, unavailable)
	required init(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: - Private Methods

private extension MainScreenView {

	// MARK: - Embed Views

	func embedViews() {

		addSubview(mainVerticalStackView)

		mainVerticalStackView.addArrangedSubview(headerContainerView)
		mainVerticalStackView.addArrangedSubview(categoriesContainerView)
		mainVerticalStackView.addArrangedSubview(collectionView)

		// MARK: Header

		headerContainerView.addSubview(headerHorizontalStackView)

		headerHorizontalStackView.addArrangedSubview(headerVerticalStackView)
		headerHorizontalStackView.addArrangedSubview(spacer)
		headerHorizontalStackView.addArrangedSubview(newTaskButton)

		headerVerticalStackView.addArrangedSubview(headerTitle)
		headerVerticalStackView.addArrangedSubview(headerSubTitle)

		// MARK: Categories of Tasks

		categoriesContainerView.addSubview(categoriesHorizontalStackView)

		categoriesHorizontalStackView.addArrangedSubview(categoryAllSummeryStackView)
		categoriesHorizontalStackView.addArrangedSubview(pipeSeparatorView)

		categoriesHorizontalStackView.addArrangedSubview(categoryOpenSummeryStackView)
		categoriesHorizontalStackView.addArrangedSubview(categoryClosedSummeryStackView)

		categoryAllSummeryStackView.addArrangedSubview(categoryAllNameLabel)
		categoryAllSummeryStackView.addArrangedSubview(categoryAllTaskCountLabel)

		categoryOpenSummeryStackView.addArrangedSubview(categoryOpenNameLabel)
		categoryOpenSummeryStackView.addArrangedSubview(categoryOpenTaskCountLabel)

		categoryClosedSummeryStackView.addArrangedSubview(categoryClosedNameLabel)
		categoryClosedSummeryStackView.addArrangedSubview(categoryClosedTaskCountLabel)

		// MARK: Tasks
		collectionView.register(ToDoCell.self, forCellWithReuseIdentifier: ToDoCell.reuseIdentifier)
		collectionView.isUserInteractionEnabled = true
	}

	// MARK: - Setup Appearance

	func setupAppearance() {
		backgroundColor = .customBackgroundColor

		mainVerticalStackView.axis = .vertical
		mainVerticalStackView.spacing = 25

		headerVerticalStackView.axis = .vertical
		headerVerticalStackView.spacing = 5

		headerHorizontalStackView.axis = .horizontal
		headerHorizontalStackView.spacing = 50

		categoriesHorizontalStackView.axis = .horizontal
		categoriesHorizontalStackView.spacing = 10

		categoryAllSummeryStackView.axis = .horizontal
		categoryAllSummeryStackView.spacing = 5

		categoryOpenSummeryStackView.axis = .horizontal
		categoryOpenSummeryStackView.spacing = 5

		categoryClosedSummeryStackView.axis = .horizontal
		categoryClosedSummeryStackView.spacing = 5

		headerSubTitle.textColor = .gray
		newTaskButton.setTitleColor(.blue, for: .normal)

		pipeSeparatorView.textColor = .gray

		collectionView.backgroundColor = .clear
		collectionView.showsVerticalScrollIndicator = false

	}

	// MARK: - Setup Layout

	func setupLayout() {
		mainVerticalStackView.translatesAutoresizingMaskIntoConstraints = false

		headerVerticalStackView.translatesAutoresizingMaskIntoConstraints = false
		headerHorizontalStackView.translatesAutoresizingMaskIntoConstraints = false

		categoriesHorizontalStackView.translatesAutoresizingMaskIntoConstraints = false
		categoryAllSummeryStackView.translatesAutoresizingMaskIntoConstraints = false
		categoryOpenSummeryStackView.translatesAutoresizingMaskIntoConstraints = false
		categoryClosedSummeryStackView.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			mainVerticalStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
			mainVerticalStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
			mainVerticalStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
			mainVerticalStackView.bottomAnchor.constraint(equalTo:safeAreaLayoutGuide.bottomAnchor),

			headerContainerView.heightAnchor.constraint(equalToConstant: 75),
			categoriesContainerView.heightAnchor.constraint(equalToConstant: 25),
		])
	}

	// MARK: - Setup Data

	func setupData() {
		headerTitle.text = "Today's Task"

		let currentDateFormatter = DateFormatter()
		currentDateFormatter.dateFormat = "EEEE, MMM d"

		headerSubTitle.text = currentDateFormatter.string(from: Date())
		newTaskButton.setTitle("+ New Task", for: .normal)

		categoryAllNameLabel.text = "All"
		categoryAllTaskCountLabel.text = "35"

		categoryOpenNameLabel.text = "Open"
		categoryOpenTaskCountLabel.text = "14"

		categoryClosedNameLabel.text = "Closed"
		categoryClosedTaskCountLabel.text = "19"

		pipeSeparatorView.text = " | "

		// Collection view stuff

	}
}

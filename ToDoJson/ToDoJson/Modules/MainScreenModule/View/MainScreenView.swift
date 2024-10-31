import UIKit

/// RootView for the `MainScreen`
final class MainScreenView: UIView {

	// MARK: - UI Elements

	private let mainVerticalStackView = UIStackView()

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
	let collectionView = UICollectionView(frame: .zero,
										  collectionViewLayout: UICollectionViewFlowLayout())


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

// MARK: - Embed Views

private extension MainScreenView {

	func embedViews() {

		addSubview(mainVerticalStackView)

		mainVerticalStackView.addArrangedSubviews([

			headerContainerView,
			categoriesContainerView,
			collectionView
		])

		// MARK: Header

		headerContainerView.addSubview(headerHorizontalStackView)

		headerHorizontalStackView.addArrangedSubviews([

			headerVerticalStackView,
			spacer,
			newTaskButton
		])

		headerVerticalStackView.addArrangedSubviews([

			headerTitle,
			headerSubTitle
		])

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

		collectionView.register(ToDoCell.self, forCellWithReuseIdentifier: ToDoCell.reuseIdentifier)
	}
}

// MARK: - Setup Appearance

private extension MainScreenView {

	func setupAppearance() {
		backgroundColor = .customBackgroundColor

		headerTitle.font = UIFont.systemFont(ofSize: 25, weight: .bold)

		newTaskButton.setTitleColor(.systemBlue, for: .normal)
		newTaskButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
		newTaskButton.layer.cornerRadius = 15
		newTaskButton.layer.masksToBounds = true
		newTaskButton.backgroundColor = UIColor.blue.withAlphaComponent(0.1)

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
}

// MARK: - Setup Layout

private extension MainScreenView {

	func setupLayout() {

		disableAutoresizingMask([

			mainVerticalStackView,

			headerVerticalStackView,
			headerHorizontalStackView,

			categoriesHorizontalStackView,
			categoryAllSummeryStackView,
			categoryOpenSummeryStackView,
			categoryClosedSummeryStackView
		])

		NSLayoutConstraint.activate([
			mainVerticalStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
			mainVerticalStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
			mainVerticalStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
			mainVerticalStackView.bottomAnchor.constraint(equalTo:safeAreaLayoutGuide.bottomAnchor),

			headerContainerView.heightAnchor.constraint(equalToConstant: 75),
			categoriesContainerView.heightAnchor.constraint(equalToConstant: 25)
		])
	}
}

// MARK: - Setup Data

private extension MainScreenView {

	func setupData() {
		headerTitle.text = "Today's Task"

		let currentDateFormatter = DateFormatter()
		currentDateFormatter.dateFormat = "EEEE, MMM d"

		headerSubTitle.text = currentDateFormatter.string(from: Date())
		newTaskButton.setTitle("  + New Task  ", for: .normal)
		
		categoryAllNameLabel.text = "All"
		categoryAllTaskCountLabel.text = "35"

		categoryOpenNameLabel.text = "Open"
		categoryOpenTaskCountLabel.text = "14"

		categoryClosedNameLabel.text = "Closed"
		categoryClosedTaskCountLabel.text = "19"

		pipeSeparatorView.text = " | "
	}
}

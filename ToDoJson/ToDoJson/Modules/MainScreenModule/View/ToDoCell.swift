import UIKit

/// Custom cell for  `ToDo` at the MainScreen
final class ToDoCell: UICollectionViewCell {

	// MARK: - Public Properties

	/// Individual ID for the cell
	static let reuseIdentifier = "ToDoCell"

	// MARK: - Private Properties

	private let titleLabel = UILabel()
	private let descriptionLabel = UILabel()
	private let checkboxImageView = UIImageView()
	private let topSpacer = UIView()
	private let dividerView = UIView()
	private let bottomSpacer = UIView()
	private let verticalStackView = UIStackView()
	private let horizontalStackView = UIStackView()

	private let dateStackView = UIStackView()
	private let deadlineLabel = UILabel()
	private let creationDateLabel = UILabel()
	private let dateSpacer = UIView()

	private let bottomSpacerSeparator = UIView()
	private let topSpacerSeparator = UIView()

	// MARK: - Initialization

	override init(frame: CGRect) {
		super.init(frame: frame)
		embedViews()
		setupAppearance()
		setupLayout()
		setupBehaviour()
		setupData()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Private Methods

	private func embedViews() {
		// Add container view to content view
		contentView.addSubview(horizontalStackView)
		contentView.addSubview(bottomSpacerSeparator)
		contentView.addSubview(topSpacerSeparator)

		// Add subviews to vertical stack view

		verticalStackView.addArrangedSubview(titleLabel)
		verticalStackView.addArrangedSubview(descriptionLabel)
		verticalStackView.addArrangedSubview(topSpacer)
		verticalStackView.addArrangedSubview(dividerView)
		verticalStackView.addArrangedSubview(bottomSpacer)

		verticalStackView.addArrangedSubview(dateStackView)

		// Add vertical stack view and checkbox image view to horizontal stack view

		dateStackView.addArrangedSubview(creationDateLabel)
		dateStackView.addArrangedSubview(deadlineLabel)
		dateStackView.addArrangedSubview(dateSpacer)

		horizontalStackView.addArrangedSubview(verticalStackView)
		horizontalStackView.addArrangedSubview(checkboxImageView)
	}

	private func setupAppearance() {
		// Configure labels
		titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
		titleLabel.numberOfLines = 0

		descriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
		descriptionLabel.textColor = .gray

		deadlineLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
		deadlineLabel.textColor = .lightGray

		creationDateLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
		creationDateLabel.textColor = .gray

		// Configure checkbox image view
		checkboxImageView.contentMode = .scaleAspectFit
		checkboxImageView.isUserInteractionEnabled = true

		// Configure divider view
		dividerView.backgroundColor = .lightGray

		// Configure stack views
		verticalStackView.axis = .vertical
		verticalStackView.spacing = 1

		horizontalStackView.axis = .horizontal
		horizontalStackView.spacing = 8

		dateStackView.axis = .horizontal
		dateStackView.spacing = 10

		// Style the cell with rounded corners and background color
		contentView.layer.cornerRadius = 15
		contentView.layer.masksToBounds = true
		contentView.backgroundColor = .white

		bottomSpacerSeparator.backgroundColor = UIColor.customBackgroundColor
		topSpacerSeparator.backgroundColor = UIColor.customBackgroundColor
	}

	private func setupLayout() {
		horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
		bottomSpacerSeparator.translatesAutoresizingMaskIntoConstraints = false
		topSpacerSeparator.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([


			topSpacerSeparator.topAnchor.constraint(equalTo: contentView.topAnchor),
			topSpacerSeparator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			topSpacerSeparator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			topSpacerSeparator.heightAnchor.constraint(equalToConstant: 5), // Adjust height as needed


			// Constraints for horizontalStackView within middleContainerView with padding
			horizontalStackView.topAnchor.constraint(equalTo: topSpacerSeparator.bottomAnchor, constant: 8),
			horizontalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
			horizontalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

			// Constraints for bottomSpacerSeparator at the bottom of content view
			bottomSpacerSeparator.topAnchor.constraint(equalTo: horizontalStackView.bottomAnchor, constant: 8),
			bottomSpacerSeparator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			bottomSpacerSeparator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			bottomSpacerSeparator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
			bottomSpacerSeparator.heightAnchor.constraint(equalToConstant: 5), // Adjust height as needed

			topSpacer.heightAnchor.constraint(equalToConstant: 5),
			dividerView.heightAnchor.constraint(equalToConstant: 1),
			bottomSpacer.heightAnchor.constraint(equalToConstant: 5),

			checkboxImageView.widthAnchor.constraint(equalToConstant: 24), // Set a fixed width for the checkbox
		])
	}

	private func setupBehaviour() {
		// Add any interactive behavior here (e.g., tap gestures)
	}

	private func setupData() {
		// Initialize default data if needed
	}

	func configure(with todo: ToDo) {
		titleLabel.text = todo.todo
		descriptionLabel.text = todo.taskDescription ?? ""

		let deadlineFormatter = DateFormatter()
		deadlineFormatter.dateStyle = .medium

		deadlineLabel.text = todo.deadline != nil ? deadlineFormatter.string(from: todo.deadline ?? Date()) : "No deadline"

		let dateCreationFormatter = DateFormatter()
		dateCreationFormatter.dateStyle = .short

		creationDateLabel.text = todo.creationDate != nil ? dateCreationFormatter.string(from: todo.creationDate ?? Date()) : "Today"

		let imageName = todo.completed ? "checkmark.circle.fill" : "circle"

		checkboxImageView.image = UIImage(systemName: imageName)
	}
}

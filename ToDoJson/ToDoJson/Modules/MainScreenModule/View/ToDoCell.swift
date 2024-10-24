import UIKit

/// Custom cell for  `ToDo` at the MainScreen
final class ToDoCell: UICollectionViewCell {

	// MARK: - Public Properties

	/// Individual ID for the cell
	static let reuseIdentifier = "ToDoCell"

	// MARK: - Private Properties

	private let topSpacerSeparator = UIView()

	private let horizontalStackView = UIStackView()

	private let verticalStackView = UIStackView()

	private let titleLabel = UILabel()
	private let descriptionLabel = UILabel()
	private let checkboxImageView = UIImageView()
	private let topSpacer = UIView()
	private let dividerView = UIView()
	private let bottomSpacer = UIView()

	private let dateStackView = UIStackView()
	private let deadlineLabel = UILabel()
	private let creationDateLabel = UILabel()
	private let dateSpacer = UIView()

	private let bottomSpacerSeparator = UIView()

	// MARK: - Initialization

	override init(frame: CGRect) {
		super.init(frame: frame)
		embedViews()
		setupAppearance()
		setupLayout()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: - Public Methods

// MARK: - Configure Cell

extension ToDoCell {

	/// Method to populate each cell with `ToDo`s data
	func configure(with todo: ToDo) {
		titleLabel.text = todo.todo

		if todo.completed {
			let attributedString = NSAttributedString(string: todo.todo, attributes: [
				.strikethroughStyle: NSUnderlineStyle.single.rawValue,
				.foregroundColor: UIColor.black
			])
			titleLabel.attributedText = attributedString
		} else if !todo.completed {
			titleLabel.attributedText = NSAttributedString(string: todo.todo)
		}
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

// MARK: - Private Methods

// MARK: - EmbedViews

private extension ToDoCell {

	func embedViews() {
		contentView.addSubview(horizontalStackView)
		contentView.addSubview(bottomSpacerSeparator)
		contentView.addSubview(topSpacerSeparator)

		verticalStackView.addArrangedSubview(titleLabel)
		verticalStackView.addArrangedSubview(descriptionLabel)
		verticalStackView.addArrangedSubview(topSpacer)
		verticalStackView.addArrangedSubview(dividerView)
		verticalStackView.addArrangedSubview(bottomSpacer)

		verticalStackView.addArrangedSubview(dateStackView)

		dateStackView.addArrangedSubview(creationDateLabel)
		dateStackView.addArrangedSubview(deadlineLabel)
		dateStackView.addArrangedSubview(dateSpacer)

		horizontalStackView.addArrangedSubview(verticalStackView)
		horizontalStackView.addArrangedSubview(checkboxImageView)
	}
}

// MARK: - SetupAppearance

private extension ToDoCell {

	func setupAppearance() {
		titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .medium)
		titleLabel.numberOfLines = 0

		descriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
		descriptionLabel.textColor = .gray

		deadlineLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
		deadlineLabel.textColor = .lightGray

		creationDateLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
		creationDateLabel.textColor = .gray

		checkboxImageView.contentMode = .scaleAspectFit
		checkboxImageView.isUserInteractionEnabled = true

		dividerView.backgroundColor = .lightGray

		verticalStackView.axis = .vertical
		verticalStackView.spacing = 1

		horizontalStackView.axis = .horizontal
		horizontalStackView.spacing = 8

		dateStackView.axis = .horizontal
		dateStackView.spacing = 10

		contentView.layer.cornerRadius = 15
		contentView.layer.masksToBounds = true
		contentView.backgroundColor = .white

		bottomSpacerSeparator.backgroundColor = .customBackgroundColor
		topSpacerSeparator.backgroundColor = .customBackgroundColor
	}
}

// MARK: - SetupLayout

private extension ToDoCell {

	private func setupLayout() {

		disableAutoresizingMask([

		horizontalStackView,
		bottomSpacerSeparator,
		topSpacerSeparator
		])

		NSLayoutConstraint.activate([

			topSpacerSeparator.topAnchor.constraint(equalTo: contentView.topAnchor),
			topSpacerSeparator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			topSpacerSeparator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			topSpacerSeparator.heightAnchor.constraint(equalToConstant: 5),

			horizontalStackView.topAnchor.constraint(equalTo: topSpacerSeparator.bottomAnchor, constant: 8),
			horizontalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
			horizontalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

			bottomSpacerSeparator.topAnchor.constraint(equalTo: horizontalStackView.bottomAnchor, constant: 8),
			bottomSpacerSeparator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			bottomSpacerSeparator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			bottomSpacerSeparator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
			bottomSpacerSeparator.heightAnchor.constraint(equalToConstant: 5),

			topSpacer.heightAnchor.constraint(equalToConstant: 5),
			dividerView.heightAnchor.constraint(equalToConstant: 1),
			bottomSpacer.heightAnchor.constraint(equalToConstant: 5),

			checkboxImageView.widthAnchor.constraint(equalToConstant: 24)
		])
	}
}

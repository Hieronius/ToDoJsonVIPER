import UIKit

/// `RootView` for the TaskScreen
final class TaskScreenView: UIView {
	
	// MARK: - Properties
	
	private let mainVerticalStackView = UIStackView()
	
	// MARK: Task Title Section
	
	private let taskTitleContainerView = UIView()
	private let taskTitleHorizontalStackView = UIStackView()
	private let taskTitleVerticalStackView = UIStackView()
	private let taskTitleLabel = UILabel()

	/// Field to write an actual task to accomplish
	let taskTitleTextField = UITextField()
	
	// MARK: Task Description Section
	
	private let topSpacer = UIView()
	private let taskDescriptionLabel = UILabel()

	/// Field to write a description of the task
	let taskDescriptionTextField = UITextField()
	
	// MARK: Deadline Section
	
	private let midSpacer = UIView()
	private let deadlineContainerView = UIView()
	private let deadlineHorizontalStackView = UIStackView()
	private let deadlineLabel = UILabel()

	/// Field to choose the date of task's deadline
	let deadlineDatePicker = UIDatePicker()
	private let bottomSpacer = UIView()

	/// Button to end the editing of the task
	let doneButton = UIButton()
	
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

private extension TaskScreenView {
	
	// MARK: - Embed Views
	
	func embedViews() {
		addSubview(mainVerticalStackView)

		mainVerticalStackView.addArrangedSubviews([

			taskTitleContainerView,
			taskDescriptionLabel,
			taskDescriptionTextField,
			midSpacer,
			deadlineContainerView,
			doneButton,
			bottomSpacer
		])
		
		taskTitleContainerView.addSubview(taskTitleHorizontalStackView)
		taskTitleHorizontalStackView.addArrangedSubview(taskTitleVerticalStackView)
		
		taskTitleVerticalStackView.addArrangedSubview(taskTitleLabel)
		taskTitleVerticalStackView.addArrangedSubview(taskTitleTextField)
		
		deadlineContainerView.addSubview(deadlineHorizontalStackView)
		deadlineHorizontalStackView.addArrangedSubview(deadlineLabel)
		deadlineHorizontalStackView.addArrangedSubview(deadlineDatePicker)
	}

}

// MARK: - Setup Appearance

private extension TaskScreenView {

	func setupAppearance() {
		backgroundColor = .customBackgroundColor
		
		mainVerticalStackView.axis = .vertical
		mainVerticalStackView.spacing = 10
		
		taskTitleHorizontalStackView.axis = .horizontal
		taskTitleHorizontalStackView.spacing = 8
		
		taskTitleVerticalStackView.axis = .vertical
		taskTitleVerticalStackView.spacing = 5
		
		deadlineHorizontalStackView.axis = .horizontal
		deadlineHorizontalStackView.spacing = 5
		
		[taskTitleLabel, taskDescriptionLabel, deadlineLabel].forEach {
			$0.font = UIFont.systemFont(ofSize: 16
										, weight: .medium)
			$0.textColor = .black
			$0.numberOfLines = 1
		}
		
		[taskDescriptionTextField, taskTitleTextField].forEach {
			$0.borderStyle = .roundedRect
			$0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
			$0.textColor = .darkGray
			$0.backgroundColor = .white
			$0.layer.cornerRadius = 5
			$0.layer.masksToBounds = true
		}
		
		deadlineDatePicker.datePickerMode = .date
		
		doneButton.setTitleColor(.systemBlue, for: .normal)
		doneButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
		doneButton.layer.cornerRadius = 15
		doneButton.layer.masksToBounds = true
		doneButton.backgroundColor = UIColor.blue.withAlphaComponent(0.1)
	}
}

// MARK: - Setup Layout

private extension TaskScreenView {
	
	func setupLayout() {

		disableAutoresizingMask([

		mainVerticalStackView,
		taskTitleHorizontalStackView,
		deadlineHorizontalStackView
		])
		
		NSLayoutConstraint.activate([
			mainVerticalStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
			mainVerticalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
			mainVerticalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
			mainVerticalStackView.bottomAnchor.constraint(equalTo:safeAreaLayoutGuide.bottomAnchor, constant: -16),
			
			taskTitleHorizontalStackView.topAnchor.constraint(equalTo: taskTitleContainerView.topAnchor),
			taskTitleHorizontalStackView.leadingAnchor.constraint(equalTo: taskTitleContainerView.leadingAnchor),
			taskTitleHorizontalStackView.trailingAnchor.constraint(equalTo: taskTitleContainerView.trailingAnchor),
			taskTitleHorizontalStackView.bottomAnchor.constraint(equalTo: taskTitleContainerView.bottomAnchor),
			
			deadlineHorizontalStackView.topAnchor.constraint(equalTo: deadlineContainerView.topAnchor),
			deadlineHorizontalStackView.leadingAnchor.constraint(equalTo: deadlineContainerView.leadingAnchor),
			deadlineHorizontalStackView.trailingAnchor.constraint(equalTo: deadlineContainerView.trailingAnchor),
			deadlineHorizontalStackView.bottomAnchor.constraint(equalTo: deadlineContainerView.bottomAnchor),
			
			taskDescriptionTextField.heightAnchor.constraint(equalToConstant: 40),
			taskTitleTextField.heightAnchor.constraint(equalToConstant: 40),
			bottomSpacer.heightAnchor.constraint(greaterThanOrEqualToConstant: 100),
			
			doneButton.heightAnchor.constraint(equalToConstant: 40),
			doneButton.leadingAnchor.constraint(equalTo: mainVerticalStackView.leadingAnchor),
			doneButton.trailingAnchor.constraint(equalTo: mainVerticalStackView.trailingAnchor),
		])
	}
}

// MARK: - Setup Data

private extension TaskScreenView {
	
	func setupData() {
		taskTitleLabel.text = "Task Title"
		taskDescriptionLabel.text = "Task Description"
		deadlineLabel.text = "Deadline"
		
		taskDescriptionTextField.placeholder = "Enter description"
		taskTitleTextField.placeholder = "Enter title"
		
		doneButton.setTitle("Done", for: .normal)
	}
}

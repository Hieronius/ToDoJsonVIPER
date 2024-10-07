import UIKit

/// `Controller` of the TaskScreen
final class TaskScreenViewController: GenericViewController<TaskScreenView> {

	// MARK: - Public Properties

	/// Strong reference to Presenter to directly say it's "owns" it
	var presenter: TaskScreenPresenterProtocol?

	/// Task to edit which can be passed when we enter TaskScreen
	var task: ToDo?

	// MARK: - Life Cycle

	override func viewDidLoad() {
		super.viewDidLoad()
		setupBehaviour()
		populateFieldsIfEditing()
	}
}

// MARK: - Private Methods

// MARK: - SetupBehaviour

private extension TaskScreenViewController {
	func setupBehaviour() {
		rootView.doneButton.addTarget(self, action: #selector(saveTask), for: .touchUpInside)
	}

	@objc func saveTask() {
		let title = rootView.taskTitleTextField.text ?? ""
		let description = rootView.taskDescriptionTextField.text ?? ""
		let deadline = rootView.deadlineDatePicker.date

		if let existingTask = task {

			presenter?.updateTask(existingTask, title: title, isCompleted: existingTask.completed, description: description, deadline: deadline, creationDate: Date())
		} else {

			presenter?.saveTask(title: title, description: description, deadline: deadline, creationDate: Date())
		}
	}
}

// MARK: - TaskScreenViewInput

extension TaskScreenViewController: TaskScreenViewInput {

	/// Method pass the data from an existing todo to the editing screen
	func populateFieldsIfEditing() {
		guard let task else { return }
		rootView.taskTitleTextField.text = task.todo
		rootView.taskDescriptionTextField.text = task.taskDescription
		rootView.deadlineDatePicker.date = task.deadline ?? Date()
	}
}

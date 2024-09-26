import UIKit

/// Protocol that defines the interface for the View to communicate with the Presenter.
///
/// The `TaskScreenViewInput` protocol is implemented by the View (e.g., `TaskScreenViewController`)
/// to receive updates from the Presenter. It provides methods for populating task details.
protocol TaskScreenViewInput: AnyObject {

	/// Populates the UI with task details for editing.
	///
	/// - Parameter task: The `ToDo` object representing the task to be displayed.
	func populateFieldsIfEditing()
}

final class TaskScreenViewController: GenericViewController<TaskScreenView> {

	// MARK: - Public Properties

	var presenter: TaskScreenPresenterProtocol?
	var task: ToDo?

	// MARK: - Life Cycle

	override func viewDidLoad() {
		super.viewDidLoad()
		setupBehaviour()
		populateFieldsIfEditing()
	}
}

// MARK: - TaskScreenViewInput

extension TaskScreenViewController: TaskScreenViewInput {
	func populateFieldsIfEditing() {
		guard let task = task else { return }
		rootView.taskTitleTextField.text = task.todo
		rootView.taskDescriptionTextField.text = task.taskDescription
		rootView.deadlineDatePicker.date = task.deadline ?? Date()
	}
}

// MARK: - SetupBehaviour

extension TaskScreenViewController {
	func setupBehaviour() {
		rootView.doneButton.addTarget(self, action: #selector(saveTask), for: .touchUpInside)
	}

	@objc
	func saveTask() {
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

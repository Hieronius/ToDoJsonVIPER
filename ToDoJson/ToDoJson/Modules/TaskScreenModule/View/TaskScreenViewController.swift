import UIKit

final class TaskScreenViewController: GenericViewController<TaskScreenView> {

	// MARK: - Public Properties

	var presenter: TaskScreenPresenterProtocol?
	var task: ToDo? // Optional task for editing

	// MARK: - Life Cycle

	override func viewDidLoad() {
		super.viewDidLoad()
		setupBehaviour()
		populateFieldsIfEditing()
	}

}

// MARK: - Private

private extension TaskScreenViewController {
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

	// MARK: SaveTask and UpdateTask should be refactored accordingly to creationDate property
	@objc
	func saveTask() {
		   let title = rootView.taskTitleTextField.text ?? ""
		   let description = rootView.taskDescriptionTextField.text ?? ""
		   let deadline = rootView.deadlineDatePicker.date

		   if let existingTask = task {
			   // Update existing task without passing creationDate explicitly
			   presenter?.updateTask(existingTask, title: title, description: description, deadline: deadline, creationDate: Date())
		   } else {
			   // Create new task
			   presenter?.saveTask(title: title, description: description, deadline: deadline, creationDate: Date())
		   }
	   }
}

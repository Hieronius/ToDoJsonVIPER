import UIKit

final class TaskScreenViewController: GenericViewController<TaskScreenView> {

	var presenter: TaskScreenPresenterProtocol?

	override func viewDidLoad() {
		super.viewDidLoad()
		setupBehaviour()
	}

}

// MARK: - SetupBehaviour

extension TaskScreenViewController {
	func setupBehaviour() {
		rootView.doneButton.addTarget(self, action: #selector(saveNewTask), for: .touchUpInside)
	}

	@objc
	func saveNewTask() {
		print("selected")
		presenter?.saveTask(
			title: rootView.taskTitleTextField.text ?? "",
			description: rootView.taskDescriptionTextField.text ?? "",
			deadline: rootView.deadlineDatePicker.date
		)
	}
}

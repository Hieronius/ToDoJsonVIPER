import Foundation
import CoreData

/// A managed object representing a To-Do item in the application.
@objc(ToDoMO)
public class ToDoMO: NSManagedObject {
	
}

extension ToDoMO {
	
	/// Creates a fetch request for the `ToDoMO` entity.
	/// - Returns: A fetch request for `ToDoMO` objects.
	@nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoMO> {
		return NSFetchRequest<ToDoMO>(entityName: "ToDoMO")
	}
	
	/// The unique identifier for the To-Do item.
	@NSManaged public var id: Int64
	
	/// A Boolean value indicating whether the To-Do item is completed.
	@NSManaged public var completed: Bool
	
	/// The title of the To-Do item.
	@NSManaged public var todo: String
	
	/// The ID of the user associated with this To-Do item.
	@NSManaged public var userId: Int64
	
	/// A description of the task, providing additional details.
	@NSManaged public var taskDescription: String?
	
	/// The deadline for completing the To-Do item.
	@NSManaged public var deadline: Date?
	
	/// The creation date of the To-Do item.
	@NSManaged public var creationDate: Date?
}

extension ToDoMO : Identifiable {
	
}

import Foundation
import CoreData

@objc(ToDoMO)
public class ToDoMO: NSManagedObject {

}

extension ToDoMO {

	@nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoMO> {
		return NSFetchRequest<ToDoMO>(entityName: "ToDoMO")
	}

	@NSManaged public var id: Int64
	@NSManaged public var completed: Bool
	@NSManaged public var todo: String
	@NSManaged public var userId: Int64
	@NSManaged public var taskDescription: String?
	@NSManaged public var deadline: Date?

}

extension ToDoMO : Identifiable {

}

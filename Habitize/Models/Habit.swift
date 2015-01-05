import Foundation
import CoreData

@objc(Habit)
class Habit: NSManagedObject {

    @NSManaged var count: NSNumber
    @NSManaged var updated_at: NSDate
    @NSManaged var created_at: NSDate
    @NSManaged var name: String
    @NSManaged var trigger: String

}

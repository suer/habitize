import Foundation
import CoreData

@objc(Trigger)
class Trigger: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var created_at: NSDate
    @NSManaged var updated_at: NSDate
    @NSManaged var habits: NSSet

}

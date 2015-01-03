import Foundation

class HabitsViewModel: NSObject {
    var fetchedResultsController: NSFetchedResultsController

    override init() {
        let request = NSFetchRequest(entityName: "Habit")
        let nameSortDescripter = NSSortDescriptor(key: "name", ascending: true)
        let triggerNameSortDescripter = NSSortDescriptor(key: "triggerName", ascending: true)
        request.sortDescriptors = [triggerNameSortDescripter, nameSortDescripter]
        fetchedResultsController = NSFetchedResultsController(
            fetchRequest: request,
            managedObjectContext: NSManagedObjectContext.MR_defaultContext(),
            sectionNameKeyPath: "triggerName",
            cacheName: "Habit")
        super.init()
    }

    func fetch() {
        var error: NSError? = nil
        fetchedResultsController.performFetch(&error)
    }
}
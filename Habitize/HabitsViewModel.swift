import Foundation

class HabitsViewModel: NSObject {
    var fetchedResultsController: NSFetchedResultsController

    override init() {
        fetchedResultsController = Habit.MR_fetchAllGroupedBy("trigger", withPredicate: NSPredicate(format: "1 = 1"), sortedBy: "trigger", ascending: true)
        super.init()
    }

    func fetch() {
        var error: NSError? = nil
        fetchedResultsController.performFetch(&error)
        if error != nil {
            println(error)
        }
    }

    func deleteHabit(indexPath: NSIndexPath) {
        let habit = fetchedResultsController.objectAtIndexPath(indexPath) as Habit
        habit.MR_deleteEntity()
        NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait()
        fetch()
    }
}
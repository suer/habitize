import Foundation

class HabitsViewModel: NSObject {
    var fetchedResultsController: NSFetchedResultsController

    override init() {
        fetchedResultsController = HabitsViewModel.createFetchedResultsController()
        super.init()
    }

    private class func createFetchedResultsController() -> NSFetchedResultsController {
        let fetchRequest = NSFetchRequest(entityName: "Habit")
        let triggerSortDiscriptor = NSSortDescriptor(key: "trigger", ascending: true)
        let nameSortDiscriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [triggerSortDiscriptor, nameSortDiscriptor]
        return NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: NSManagedObjectContext.MR_defaultContext(), sectionNameKeyPath: "trigger", cacheName: "Habit")
    }

    func fetch() {
        var error: NSError? = nil
        fetchedResultsController.performFetch(&error)
        if error != nil {
            println(error)
        }
    }

    func countUp(indexPath: NSIndexPath) {
        editHabit(indexPath) { habit in habit.count = Int(habit.count) + 1 }
    }

    func countDown(indexPath: NSIndexPath) {
        editHabit(indexPath) { habit in habit.count = Int(habit.count) - 1 }
    }

    func deleteHabit(indexPath: NSIndexPath) {
        editHabit(indexPath) {
            habit in
            habit.MR_deleteEntity()
            return
        }
    }

    private func editHabit(indexPath: NSIndexPath, block: Habit -> ()) {
        let habit = fetchedResultsController.objectAtIndexPath(indexPath) as Habit
        block(habit)
        NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait()
        fetch()
    }
}
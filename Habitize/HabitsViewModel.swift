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
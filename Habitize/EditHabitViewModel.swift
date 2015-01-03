import Foundation

class EditHabitViewModel: NSObject {
    dynamic var triggerName = ""
    dynamic var habitName = ""

    func save() {
        let habit = Habit.MR_createEntity() as Habit
        habit.name = habitName
        habit.triggerName = triggerName
        NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait()
    }
}
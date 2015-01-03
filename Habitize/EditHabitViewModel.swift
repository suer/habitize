import Foundation

class EditHabitViewModel: NSObject {
    dynamic var triggerName = ""
    dynamic var habitName = ""

    func save() {
        let trigger = Trigger.MR_createEntity() as Trigger
        trigger.name = triggerName

        let habit = Habit.MR_createEntity() as Habit
        habit.name = habitName
        habit.trigger = trigger

        NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait()
    }
}
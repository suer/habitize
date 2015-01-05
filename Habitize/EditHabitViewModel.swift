import Foundation

class EditHabitViewModel: NSObject {
    dynamic var triggerName = ""
    dynamic var habitName = ""
    var habit: Habit

    override convenience init() {
        self.init(habit: Habit.MR_createEntity() as Habit)
    }

    init(habit: Habit) {
        self.habit = habit
        triggerName = habit.trigger
        habitName = habit.name
        super.init()
    }

    func save() {
        habit.name = habitName
        habit.trigger = triggerName
        NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait()
    }
}
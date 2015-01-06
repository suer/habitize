import Foundation

class EditHabitViewModel: NSObject {
    dynamic var triggerName = ""
    dynamic var habitName = ""
    var habit: Habit?

    override init() {
        super.init()
    }

    init(habit: Habit) {
        self.habit = habit
        triggerName = habit.trigger
        habitName = habit.name
        super.init()
    }

    func save() {
        if habit == nil {
            habit = Habit.MR_createEntity() as? Habit
        }
        habit!.name = habitName
        habit!.trigger = triggerName
        NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait()
    }
}
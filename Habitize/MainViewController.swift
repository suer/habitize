import UIKit

class MainViewController: UITableViewController {

    let habitsViewModel = HabitsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Habitize"
        view.backgroundColor = UIColor.whiteColor()
        loadAddButton()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        habitsViewModel.fetch()
        tableView.reloadData()
    }

    // MARK: add button

    func loadAddButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: Selector("addButtonTapped"))
    }

    func addButtonTapped() {
        let controller = UINavigationController(rootViewController: EditHabitViewController())
        self.modalTransitionStyle = .CoverVertical
        presentViewController(controller, animated: true, completion: nil)
    }

    // MARK: table view

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return habitsViewModel.fetchedResultsController.sections?.count ?? 0
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return habitsViewModel.fetchedResultsController.sections?[section].name ?? ""
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo: AnyObject? = habitsViewModel.fetchedResultsController.sections?[section]
        return sectionInfo?.numberOfObjects ?? 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let habit = habitsViewModel.fetchedResultsController.objectAtIndexPath(indexPath) as Habit
        let cell = UITableViewCell(style: .Value1, reuseIdentifier: "Cell")
        cell.textLabel?.text = habit.name
        cell.detailTextLabel?.text = habit.count.stringValue
        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let habit = habitsViewModel.fetchedResultsController.objectAtIndexPath(indexPath) as Habit
        let editHabitViewModel = EditHabitViewModel(habit: habit)

        var buttonActions = [SheetAction]()
        buttonActions.append(SheetAction(
            title: NSLocalizedString("Edit", comment: ""),
            action: {self.presentHabitViewController(editHabitViewModel)}
            ))
        buttonActions.append(SheetAction(
            title: NSLocalizedString("Count Up", comment: ""),
            action: {self.countUp(indexPath)}
            ))
        if habit.count.integerValue > 0 {
            buttonActions.append(SheetAction(
                title: NSLocalizedString("Count Down", comment: ""),
                action: {self.countDown(indexPath)}
                ))
        }
        buttonActions.append(SheetAction(
            title: NSLocalizedString("Delete", comment: ""),
            action: {self.deleteRowWithConfirmation(indexPath)}
            ))

        RMUniversalAlert.showActionSheetInViewController(self,
            withTitle: habit.trigger,
            message: habit.name,
            cancelButtonTitle: NSLocalizedString("Cancel", comment: ""),
            destructiveButtonTitle: nil,
            otherButtonTitles: buttonActions.map {action in action.title},
            tapBlock: {
                index in
                if index >= UIAlertControllerBlocksFirstOtherButtonIndex {
                    buttonActions[index - UIAlertControllerBlocksFirstOtherButtonIndex].action()
                }
                return
        })
    }

    func presentHabitViewController(editHabitViewModel: EditHabitViewModel) {
        let controller = UINavigationController(rootViewController: EditHabitViewController(editHabitViewModel: editHabitViewModel))
        self.modalTransitionStyle = .CoverVertical
        presentViewController(controller, animated: true, completion: nil)
    }

    private func countUp(indexPath: NSIndexPath) {
        habitsViewModel.countUp(indexPath)
        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }

    private func countDown(indexPath: NSIndexPath) {
        habitsViewModel.countDown(indexPath)
        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }

    private func deleteRowWithConfirmation(indexPath: NSIndexPath) {
        RMUniversalAlert.showAlertInViewController(self,
            withTitle: NSLocalizedString("Confirmation", comment: ""),
            message: NSLocalizedString("Are you sure you want to delete it?", comment: ""),
            cancelButtonTitle: NSLocalizedString("Cancel", comment: ""),
            destructiveButtonTitle: nil,
            otherButtonTitles: [NSLocalizedString("Yes", comment: "")]) {
                index in
                switch index {
                case UIAlertControllerBlocksFirstOtherButtonIndex:
                    self.deleteRow(indexPath)
                default:
                    break
                }
        }
    }

    private func deleteRow(indexPath: NSIndexPath) {
        tableView.beginUpdates()
        habitsViewModel.deleteHabit(indexPath)
        if tableView.numberOfRowsInSection(indexPath.section) == 1 {
            tableView.deleteSections(NSIndexSet(index: indexPath.section), withRowAnimation: .Automatic)
        }
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        tableView.endUpdates()
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == .Delete) {
            deleteRowWithConfirmation(indexPath)
        }
    }
}

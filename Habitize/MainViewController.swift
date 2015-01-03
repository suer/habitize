import UIKit

class MainViewController: UITableViewController {

    let exampleData = [
        "Trigger1": [
            "habit1",
            "habit2"
        ],
        "Trigger2": [
            "habit3",
            "habit4",
            "habit5"
        ]
    ]

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
        println(habitsViewModel.fetchedResultsController.sections?.count)
        return habitsViewModel.fetchedResultsController.sections?.count ?? 0
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        println(habitsViewModel.fetchedResultsController.sections?[section].name)
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
        RMUniversalAlert.showActionSheetInViewController(self,
            withTitle: "",
            message: "",
            cancelButtonTitle: NSLocalizedString("Cancel", comment: ""),
            destructiveButtonTitle: nil,
            otherButtonTitles: [NSLocalizedString("Edit", comment: ""), NSLocalizedString("Count up", comment: "")],
            tapBlock: {
                index in
                return
        })
    }
}

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

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Habitize"
        view.backgroundColor = UIColor.whiteColor()
        loadAddButton()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
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
        return exampleData.count
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return exampleData.keys.array[section]
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exampleData.values.array[section].count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "Cell")
        cell.textLabel?.text = exampleData.values.array[indexPath.section][indexPath.row]
        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}

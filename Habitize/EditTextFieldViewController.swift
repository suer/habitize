import UIKit

class EditTextFieldViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let rowHeight = CGFloat(44.0)
    let tableView = UITableView()

    let labelText: String
    let editHabitViewModel: EditHabitViewModel
    let textField = UITextField()

    init(labelText: String, editHabitViewModel: EditHabitViewModel) {
        self.labelText = labelText
        self.editHabitViewModel = editHabitViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        view.autoresizingMask = .FlexibleHeight | .FlexibleWidth
        edgesForExtendedLayout = UIRectEdge.None
        loadForm()
        loadTableView()
        loadCloseButton()
    }

    // MARK: form
    private func loadForm() {
        let label = UILabel()
        label.text = labelText
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(label)
        view.addConstraints([
            NSLayoutConstraint(item: label, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: rowHeight / 2.0),
            NSLayoutConstraint(item: label, attribute: .Right, relatedBy: .Equal, toItem: view, attribute: .Right, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: label, attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: rowHeight),
            NSLayoutConstraint(item: label, attribute: .Left, relatedBy: .Equal, toItem: view, attribute: .Left, multiplier: 1.0, constant: 0.0)
            ])

        textField.setTranslatesAutoresizingMaskIntoConstraints(false)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGrayColor().CGColor
        textField.text = editHabitViewModel.triggerName
        view.addSubview(textField)
        view.addConstraints([
            NSLayoutConstraint(item: textField, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: rowHeight),
            NSLayoutConstraint(item: textField, attribute: .Right, relatedBy: .Equal, toItem: view, attribute: .Right, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: textField, attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: rowHeight * 2),
            NSLayoutConstraint(item: textField, attribute: .Left, relatedBy: .Equal, toItem: view, attribute: .Left, multiplier: 1.0, constant: 0.0)
            ])
        textField.addTarget(self, action: Selector("triggerChanged:"), forControlEvents: .EditingChanged)

        textField.becomeFirstResponder()
    }

    func triggerChanged(textField :UITextField) {
        editHabitViewModel.triggerName = textField.text
    }

    // MARK: table view
    private func loadTableView() {
        tableView.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(tableView)
        view.addConstraints([
            NSLayoutConstraint(item: tableView, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: rowHeight * 2),
            NSLayoutConstraint(item: tableView, attribute: .Right, relatedBy: .Equal, toItem: view, attribute: .Right, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: tableView, attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute: .Bottom, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: tableView, attribute: .Left, relatedBy: .Equal, toItem: view, attribute: .Left, multiplier: 1.0, constant: 0.0)
            ])
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell(style: .Default, reuseIdentifier: "Cell")
    }

    // MARK: close button
    private func loadCloseButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Close", style: .Plain, target: self, action: Selector("closeButtonTapped"))
    }

    func closeButtonTapped() {
        dismissViewControllerAnimated(false, completion: nil)
    }
}

import UIKit

class EditHabitViewController: UIViewController {

    let rowHeight = CGFloat(44.0)
    let editHabitViewModel: EditHabitViewModel

    override convenience init() {
        self.init(editHabitViewModel: EditHabitViewModel())
    }

    init(editHabitViewModel: EditHabitViewModel) {
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
        loadTriggerForm()
        loadHabitForm()
        loadCancelButton()
        loadSaveButton()
    }

    // MARK: trigger

    private func loadTriggerForm() {
        let label = UILabel()
        label.text = NSLocalizedString("Trigger", comment: "")
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(label)
        view.addConstraints([
            NSLayoutConstraint(item: label, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: rowHeight / 2.0),
            NSLayoutConstraint(item: label, attribute: .Right, relatedBy: .Equal, toItem: view, attribute: .Right, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: label, attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: rowHeight),
            NSLayoutConstraint(item: label, attribute: .Left, relatedBy: .Equal, toItem: view, attribute: .Left, multiplier: 1.0, constant: 0.0)
            ])

        let textField = UITextField()
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

    }

    func triggerChanged(textField: UITextField) {
        editHabitViewModel.triggerName = textField.text
    }

    // MARK: habit

    private func loadHabitForm() {
        let rect = (width: 10, height: 11)
        let label = UILabel()
        label.text = NSLocalizedString("Habit", comment: "")
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(label)
        view.addConstraints([
            NSLayoutConstraint(item: label, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: rowHeight * 5 / 2.0),
            NSLayoutConstraint(item: label, attribute: .Right, relatedBy: .Equal, toItem: view, attribute: .Right, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: label, attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: rowHeight * 3.0),
            NSLayoutConstraint(item: label, attribute: .Left, relatedBy: .Equal, toItem: view, attribute: .Left, multiplier: 1.0, constant: 0.0)
            ])

        let textField = UITextField()
        textField.setTranslatesAutoresizingMaskIntoConstraints(false)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGrayColor().CGColor
        textField.text = editHabitViewModel.habitName
        view.addSubview(textField)
        view.addConstraints([
            NSLayoutConstraint(item: textField, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: rowHeight * 3.0),
            NSLayoutConstraint(item: textField, attribute: .Right, relatedBy: .Equal, toItem: view, attribute: .Right, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: textField, attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: rowHeight * 4.0),
            NSLayoutConstraint(item: textField, attribute: .Left, relatedBy: .Equal, toItem: view, attribute: .Left, multiplier: 1.0, constant: 0.0)
            ])
        textField.addTarget(self, action: Selector("habitChanged:"), forControlEvents: .EditingChanged)
    }

    func habitChanged(textField: UITextField) {
        editHabitViewModel.habitName =  textField.text
    }

    // MARK: cancel button
    private func loadCancelButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: Selector("cancelButtonTapped"))
    }

    func cancelButtonTapped() {
        NSManagedObjectContext.MR_defaultContext().rollback()
        dismissViewControllerAnimated(true, completion: nil)
    }

    // MARK: save button
    private func loadSaveButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .Plain, target: self, action: Selector("saveButtonTapped"))
    }

    func saveButtonTapped() {
        editHabitViewModel.save()
        dismissViewControllerAnimated(true, completion: nil)
    }
}

import UIKit

class EditHabitViewController: UIViewController {

    let rowHeight = CGFloat(44.0)
    let editHabitViewModel: EditHabitViewModel
    let triggerTextField = UITextField()
    let habitTextField = UITextField()
    let saveButton = UIBarButtonItem()

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

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        triggerTextField.text = editHabitViewModel.triggerName
        setEnabledToSaveButton()
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

        triggerTextField.setTranslatesAutoresizingMaskIntoConstraints(false)
        triggerTextField.layer.borderWidth = 1
        triggerTextField.layer.borderColor = UIColor.lightGrayColor().CGColor
        triggerTextField.text = editHabitViewModel.triggerName
        triggerTextField.leftViewMode = .Always
        triggerTextField.leftView = UIView(frame: CGRectMake(0, 0, 15, triggerTextField.bounds.height))
        view.addSubview(triggerTextField)
        view.addConstraints([
            NSLayoutConstraint(item: triggerTextField, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: rowHeight),
            NSLayoutConstraint(item: triggerTextField, attribute: .Right, relatedBy: .Equal, toItem: view, attribute: .Right, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: triggerTextField, attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: rowHeight * 2),
            NSLayoutConstraint(item: triggerTextField, attribute: .Left, relatedBy: .Equal, toItem: view, attribute: .Left, multiplier: 1.0, constant: 0.0)
            ])
        triggerTextField.addTarget(self, action: Selector("triggerTapped:"), forControlEvents: .EditingDidBegin)
    }

    func triggerTapped(textField: UITextField) {
        textField.resignFirstResponder()
        let controller = UINavigationController(rootViewController: EditTextFieldViewController(labelText: NSLocalizedString("Trigger", comment: ""), editHabitViewModel: editHabitViewModel))
        self.modalTransitionStyle = .CoverVertical
        presentViewController(controller, animated: false, completion: nil)
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

        habitTextField.setTranslatesAutoresizingMaskIntoConstraints(false)
        habitTextField.layer.borderWidth = 1
        habitTextField.layer.borderColor = UIColor.lightGrayColor().CGColor
        habitTextField.text = editHabitViewModel.habitName
        habitTextField.leftViewMode = .Always
        habitTextField.leftView = UIView(frame: CGRectMake(0, 0, 15, habitTextField.bounds.height))

        view.addSubview(habitTextField)
        view.addConstraints([
            NSLayoutConstraint(item: habitTextField, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: rowHeight * 3.0),
            NSLayoutConstraint(item: habitTextField, attribute: .Right, relatedBy: .Equal, toItem: view, attribute: .Right, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: habitTextField, attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: rowHeight * 4.0),
            NSLayoutConstraint(item: habitTextField, attribute: .Left, relatedBy: .Equal, toItem: view, attribute: .Left, multiplier: 1.0, constant: 0.0)
            ])
        habitTextField.addTarget(self, action: Selector("habitChanged:"), forControlEvents: .EditingChanged)
    }

    func habitChanged(textField: UITextField) {
        editHabitViewModel.habitName =  textField.text
        setEnabledToSaveButton()
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
        saveButton.title = NSLocalizedString("Save", comment: "")
        saveButton.style = .Plain
        saveButton.target = self
        saveButton.action = Selector("saveButtonTapped")
        navigationItem.rightBarButtonItem = saveButton
    }

    func saveButtonTapped() {
        editHabitViewModel.save()
        dismissViewControllerAnimated(true, completion: nil)
    }

    func setEnabledToSaveButton() {
        saveButton.enabled = !(triggerTextField.text.isEmpty || habitTextField.text.isEmpty)
    }
}

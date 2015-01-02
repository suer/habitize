import UIKit

class EditHabitViewController: UIViewController {

    let rowHeight = CGFloat(44.0)

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
        label.text = "Trigger"
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
        view.addSubview(textField)
        view.addConstraints([
            NSLayoutConstraint(item: textField, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: rowHeight),
            NSLayoutConstraint(item: textField, attribute: .Right, relatedBy: .Equal, toItem: view, attribute: .Right, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: textField, attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: rowHeight * 2),
            NSLayoutConstraint(item: textField, attribute: .Left, relatedBy: .Equal, toItem: view, attribute: .Left, multiplier: 1.0, constant: 0.0)
            ])
    }

    // MARK: habit

    private func loadHabitForm() {
        let label = UILabel()
        label.text = "Habit"
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
        view.addSubview(textField)
        view.addConstraints([
            NSLayoutConstraint(item: textField, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: rowHeight * 3.0),
            NSLayoutConstraint(item: textField, attribute: .Right, relatedBy: .Equal, toItem: view, attribute: .Right, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: textField, attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: rowHeight * 4.0),
            NSLayoutConstraint(item: textField, attribute: .Left, relatedBy: .Equal, toItem: view, attribute: .Left, multiplier: 1.0, constant: 0.0)
            ])
    }

    // MARK: cancel button
    private func loadCancelButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: Selector("cancelButtonTapped"))
    }

    func cancelButtonTapped() {
        dismissViewControllerAnimated(true, completion: nil)
    }

    // MARK: save button
    private func loadSaveButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .Plain, target: self, action: Selector("saveButtonTapped"))
    }

    func saveButtonTapped() {
        dismissViewControllerAnimated(true, completion: nil)
    }
}

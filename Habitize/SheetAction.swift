import Foundation

class SheetAction {
    let title: String
    let action: () -> ()
    init(title: String, action: () -> ()) {
        self.title = title
        self.action = action
    }
}
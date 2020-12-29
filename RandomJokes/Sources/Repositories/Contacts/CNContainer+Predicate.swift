import Contacts
import Foundation

extension CNContainer {
    var matchAll: NSPredicate {
        CNContact.predicateForContactsInContainer(withIdentifier: identifier)
    }
}

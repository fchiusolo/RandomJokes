import Foundation
import Contacts

extension CNContainer {
    var matchAll: NSPredicate {
        return CNContact.predicateForContactsInContainer(withIdentifier: identifier)
    }
}

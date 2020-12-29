import Contacts
import Foundation

extension CNContainer {
    func contacts(in store: CNContactStore, keys: [CNKeyDescriptor]) -> [CNContact] {
        (try? store.unifiedContacts(matching: matchAll, keysToFetch: keys)) ?? []
    }
}

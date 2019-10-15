import Foundation
import Contacts

extension CNContainer {
    func contacts(in store: CNContactStore, keys: [CNKeyDescriptor]) -> [CNContact] {
        return (try? store.unifiedContacts(matching: matchAll, keysToFetch: keys)) ?? []
    }
}

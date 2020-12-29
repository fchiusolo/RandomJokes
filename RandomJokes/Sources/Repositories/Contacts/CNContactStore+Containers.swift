import Contacts
import Foundation

extension CNContactStore {
    var allContainers: [CNContainer] {
        (try? containers(matching: nil)) ?? []
    }
}

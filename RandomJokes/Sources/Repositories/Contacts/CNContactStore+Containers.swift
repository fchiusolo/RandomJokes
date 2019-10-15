import Foundation
import Contacts

extension CNContactStore {
    var allContainers: [CNContainer] {
        return (try? containers(matching: nil)) ?? []
    }
}

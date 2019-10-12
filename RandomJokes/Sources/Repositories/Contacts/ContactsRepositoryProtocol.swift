import Foundation

enum ContactsError: Error {
    case accessDenied
    case unknown
}

protocol ContactsRepositoryProtocol {
    typealias ContactsResponseHandler = (Result<Contact, ContactsError>) -> Void
    func getContacts(_ handler: @escaping ContactsResponseHandler)
}

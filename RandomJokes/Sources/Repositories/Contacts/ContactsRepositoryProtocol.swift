import Foundation

enum ContactsError: Error {
    case accessDenied
    case unknown
}

protocol ContactsRepositoryProtocol {
    typealias ContactsResponseHandler = (Result<Contact, ContactsError>) -> Void

    func random(_ handler: @escaping ContactsResponseHandler)
}

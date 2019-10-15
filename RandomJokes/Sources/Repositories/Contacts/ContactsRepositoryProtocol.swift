import Foundation

enum ContactsError: Error {
    case accessDenied
    case unknown
}

protocol ContactsRepositoryProtocol {
    typealias ContactsResponseHandler = (Result<Contact, ContactsError>) -> Void

    func request() -> Request<Contact>
    func random(_ handler: @escaping ContactsResponseHandler)
}

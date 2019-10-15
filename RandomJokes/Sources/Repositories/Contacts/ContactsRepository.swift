import Foundation
import Contacts

struct ContactsRepository {
    private let keysToFetch = [
        CNContactFormatter.descriptorForRequiredKeys(for: .fullName)
        ] as [CNKeyDescriptor]
}

extension ContactsRepository: ContactsRepositoryProtocol {
    func request() -> Request<Contact> {
        return RandomContactRequest(repository: self)
    }
    
    func random(_ handler: @escaping Self.ContactsResponseHandler) {
        CNContactStore().requestAccess(for: .contacts) { access, _ in
            guard access else {
                handler(.failure(ContactsError.accessDenied))
                return
            }
            self.fetchAllContacts(then: handler)
        }
    }
    
    private func fetchAllContacts(then handler: @escaping Self.ContactsResponseHandler) {
        let store = CNContactStore()
        store.allContainers
            .map { $0.contacts(in: store, keys: keysToFetch)}
            .flatMap { $0 }
            .randomElement()
            .map { Contact(firstName: $0.givenName, lastName: $0.familyName) }
            .map { handler(.success($0)) }
            ?? handler(.failure(.unknown))
    }
}

private class RandomContactRequest: Request<Contact> {
    let repository: ContactsRepositoryProtocol

    init(repository: ContactsRepositoryProtocol) {
        self.repository = repository
    }

    override func execute(success: @escaping (Contact) -> Void, failure: @escaping (Error) -> Void) {
        repository.random {
            switch $0 {
            case .success(let contact):
                success(contact)
            case .failure(let error):
                failure(error)
            }
        }
    }
}

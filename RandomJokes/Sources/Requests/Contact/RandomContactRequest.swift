import Foundation

class RandomContactRequest: Request<Contact> {
    let repository: ContactsRepositoryProtocol

    init(repository: ContactsRepositoryProtocol) {
        self.repository = repository
    }

    override func execute(success: @escaping (Contact) -> Void, failure: @escaping (Error) -> Void) {
        repository.random {
            switch $0 {
            case let .success(contact):
                success(contact)
            case let .failure(error):
                failure(error)
            }
        }
    }
}

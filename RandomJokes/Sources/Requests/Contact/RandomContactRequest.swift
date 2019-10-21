import Foundation

class RandomContactRequest: Request<Contact> {
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

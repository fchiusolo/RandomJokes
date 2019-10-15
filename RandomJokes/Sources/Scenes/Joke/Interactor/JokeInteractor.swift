import Foundation

struct JokeInteractor {
    let presenter: JokePresenterProtocol
    let jokesRepository: JokesRepositoryProtocol
    let contactsRepository: ContactsRepositoryProtocol
}

extension JokeInteractor: JokeInteractorProtocol {
    func fetch() {
        contactsRepository.request()
            .map { $0.person }
            .chain(success: jokesRepository.request,
                   failure: { _ in self.jokesRepository.request(for: nil) })
            .execute(success: presenter.update,
                     failure: presenter.update)
    }
}

private extension Contact {
    var person: Person {
        return Person(firstName: firstName, lastName: lastName)
    }
}

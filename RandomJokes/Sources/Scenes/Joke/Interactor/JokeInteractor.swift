import Foundation

struct JokeInteractor {
    let presenter: JokePresenterProtocol
    let jokesRepository: JokesRepositoryProtocol
    let contactsRepository: ContactsRepositoryProtocol
}

extension JokeInteractor: JokeInteractorProtocol {
    func fetch() {
        RandomContactRequest(repository: contactsRepository)
            .map { $0.person }
            .chain(success: { PersonJokeRequest(repository: self.jokesRepository, person: $0) },
                   failure: { _ in ChuckJokeRequest(repository: self.jokesRepository) })
            .execute(success: presenter.update,
                     failure: presenter.update)
    }
}

private extension Contact {
    var person: Person {
        return Person(firstName: firstName, lastName: lastName)
    }
}

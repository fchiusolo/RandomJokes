import Foundation

struct JokeInteractor {
    var presenter: JokePresenterProtocol?
    let jokesRepository: JokesRepositoryProtocol
    let contactsRepository: ContactsRepositoryProtocol
}

extension JokeInteractor: JokeInteractorProtocol {
    func fetch() {
        RandomContactRequest(repository: contactsRepository)
            .map { $0.person }
            .chain(success: { PersonJokeRequest(repository: self.jokesRepository, person: $0) },
                   failure: { _ in ChuckJokeRequest(repository: self.jokesRepository) })
            .execute(success: { self.presenter?.update(joke: $0) },
                     failure: { self.presenter?.update(error: $0) })
    }
}

private extension Contact {
    var person: Person {
        return Person(firstName: firstName, lastName: lastName)
    }
}

import Foundation

struct JokeInteractor {
    var presenter: JokePresenterProtocol?
    let jokesRepository: JokesRepositoryProtocol
    let contactsRepository: ContactsRepositoryProtocol
}

extension JokeInteractor: JokeInteractorProtocol {
    func fetch() {
        RandomContactRequest(repository: contactsRepository)
            .map(\.person)
            .chain(success: { PersonJokeRequest(repository: self.jokesRepository, person: $0) },
                   failure: { _ in ChuckJokeRequest(repository: self.jokesRepository) })
            .execute(success: { self.presenter?.update(data: $0) },
                     failure: { self.presenter?.update(error: $0) })
    }
}

private extension Contact {
    var person: Person {
        Person(firstName: firstName, lastName: lastName)
    }
}

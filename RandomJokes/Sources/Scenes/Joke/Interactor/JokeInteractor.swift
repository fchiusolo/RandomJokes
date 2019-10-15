import Foundation

struct JokeInteractor {
    let presenter: JokePresenterProtocol
    let jokesRepository: JokesRepositoryProtocol
    let contactsRepository: ContactsRepositoryProtocol
}

extension JokeInteractor: JokeInteractorProtocol {
    func fetch() {
//        RandomContactRequest()
//            .map { $0.person }
//            .chain(PersonJokeRequest.init, { _ in ChuckJokeRequest() })
//            .execute(presenter.update, { $0.map(self.presenter.update) })
    }
}

private extension Contact {
    var person: Person {
        return Person(firstName: firstName, lastName: lastName)
    }
}

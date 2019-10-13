import Foundation

struct JokeInteractor {
    let presenter: JokePresenterProtocol
    let jokesRepository: JokesRepositoryProtocol
    let contactsRepository: ContactsRepositoryProtocol
}

extension JokeInteractor: JokeInteractorProtocol {
    func fetch() {
        contactsRepository.getContacts { result in
            switch result {
            case .success(let contact):
                self.jokesRepository.fetch(person: contact.person) { result in
                    switch result {
                    case .success(let joke):
                        self.presenter.update(joke: joke)
                    case .failure(let error):
                        self.presenter.update(error: error)
                    }
                }
            case .failure:
                self.jokesRepository.fetch(person: nil) { result in
                    switch result {
                    case .success(let joke):
                        self.presenter.update(joke: joke)
                    case .failure(let error):
                        self.presenter.update(error: error)
                    }
                }
            }
        }
    }
}

private extension Contact {
    var person: Person {
        return Person(firstName: firstName, lastName: lastName)
    }
}

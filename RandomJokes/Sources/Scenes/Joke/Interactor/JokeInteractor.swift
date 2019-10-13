import Foundation

struct JokeInteractor {
    let presenter: JokePresenterProtocol
    let jokesRepository: JokesRepositoryProtocol
    let contactsRepository: ContactsRepositoryProtocol
}

extension JokeInteractor: JokeInteractorProtocol {
    func fetch() {
        contactsRepository.random { result in
            switch result {
            case .success(let contact):
                self.joke(for: contact.person)
            case .failure:
                self.joke(for: nil)
            }
        }
    }

    private func joke(for person: Person?) {
        jokesRepository.fetch(person: person) { result in
            switch result {
            case .success(let joke):
                self.presenter.update(joke: joke)
            case .failure(let error):
                self.presenter.update(error: error)
            }
        }
    }
}

private extension Contact {
    var person: Person {
        return Person(firstName: firstName, lastName: lastName)
    }
}

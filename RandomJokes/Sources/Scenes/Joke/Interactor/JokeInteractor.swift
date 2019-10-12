import Foundation

struct JokeInteractor {
    let presenter: JokePresenterProtocol
    let jokesRepository: JokesRepositoryProtocol
    let contactsRepository: ContactsRepositoryProtocol
}

extension JokeInteractor: JokeInteractorProtocol {
    func fetchJoke() {
        contactsRepository.getContacts { result in
            switch result {
            case .success(let contact):
                self.jokesRepository.getJoke(person: contact.person) { result in
                    switch result {
                    case .success(let joke):
                        self.presenter.update(joke: joke)
                    case .failure(let error):
                        debugPrint(error.localizedDescription)
                    }
                }
            case .failure:
                self.jokesRepository.getJoke(person: nil) { result in
                    switch result {
                    case .success(let joke):
                        self.presenter.update(joke: joke)
                    case .failure(let error):
                        debugPrint(error.localizedDescription)
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
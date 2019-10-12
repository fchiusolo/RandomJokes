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
                self.getJoke(firstName: contact.firstName, lastName: contact.lastName)
            case .failure:
                self.getJoke()
            }
        }
    }
    
    private func getJoke(firstName: String? = nil, lastName: String? = nil) {
        jokesRepository.getJoke(firstName: firstName ?? "Daniele", lastName: lastName ?? "Campogiani") { result in
            switch result {
            case .success(let joke):
                self.presenter.update(joke: joke)
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
    }
}

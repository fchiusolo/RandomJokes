import Foundation

struct JokeInteractor {
    let presenter: JokePresenterProtocol
    let jokesRepository: JokesRepositoryProtocol
    let contactsRepository: ContactsRepositoryProtocol
}

extension JokeInteractor: JokeInteractorProtocol {
    func fetch() {
        ContactRequest()
            .map { $0.person }
            .chain(JokeRequestWithPerson.init, { _ in JokeRequestWithChuck() })
            .execute(presenter.update, { $0.map(self.presenter.update) })
    }
}

private extension Contact {
    var person: Person {
        return Person(firstName: firstName, lastName: lastName)
    }
}

class Request<T> {
    func execute(_ success: @escaping (T) -> Void, _ failure: @escaping (Error?) -> Void) {}
    func map<R>(_ transform: @escaping (T) -> R) -> Request<R> {
        return MapRequest(request: self, transform: transform)
    }
    func chain<R>(_ success: @escaping (T) -> Request<R>, _ failure: @escaping (Error?) -> Request<R>) -> Request<R> {
        return ChainRequest(request: self, success, failure)
    }
}

class ChainRequest<T, R>: Request<R> {
    let request: Request<T>
    let success: (T) -> Request<R>
    let failure: (Error?) -> Request<R>

    init(request: Request<T>, _ success: @escaping (T) -> Request<R>, _ failure: @escaping (Error?) -> Request<R>) {
        self.request = request
        self.success = success
        self.failure = failure
    }

    override func execute(_ success: @escaping (R) -> Void, _ failure: @escaping (Error?) -> Void) {
        request.execute({
            self.success($0).execute(success, failure)

        }, {
            self.failure($0).execute(success, failure)
        })
    }
}

class MapRequest<T, R>: Request<R> {
    let request: Request<T>
    let transform: (T) -> R

    init(request: Request<T>, transform: @escaping (T) -> R) {
        self.request = request
        self.transform = transform
    }

    override func execute(_ success: @escaping (R) -> Void, _ failure: @escaping (Error?) -> Void) {
        request.execute({ success(self.transform($0)) }, failure)
    }
}

class ContactRequest: Request<Contact> {
    override func execute(_ success: @escaping (Contact) -> Void, _ failure: @escaping (Error?) -> Void) {
        ContactsRepository().random {
            switch $0 {
            case .success(let contact):
                success(contact)
            case .failure:
                failure(nil)
            }
        }
    }
}

class JokeRequestWithPerson: Request<Joke> {
    let person: Person

    init(person: Person) {
        self.person = person
    }

    override func execute(_ success: @escaping (Joke) -> Void, _ failure: @escaping (Error?) -> Void) {
        JokesRepository().fetch(person: person) {
            switch $0 {
            case .success(let joke):
                success(joke)
            case .failure(let error):
                failure(error)
            }
        }
    }
}

class JokeRequestWithChuck: Request<Joke> {
    override func execute(_ success: @escaping (Joke) -> Void, _ failure: @escaping (Error?) -> Void) {
        JokesRepository().fetch(person: nil) {
            switch $0 {
            case .success(let joke):
                success(joke)
            case .failure(let error):
                failure(error)
            }
        }
    }
}

import Foundation

class PersonJokeRequest: Request<(Joke, Person?)> {
    let repository: JokesRepositoryProtocol
    let person: Person

    init(repository: JokesRepositoryProtocol, person: Person) {
        self.repository = repository
        self.person = person
    }

    override func execute(success: @escaping ((Joke, Person?)) -> Void, failure: @escaping (Error) -> Void) {
        repository.fetch(person: person) {
            switch $0 {
            case let .success(joke):
                success(joke)
            case let .failure(error):
                failure(error)
            }
        }
    }
}
